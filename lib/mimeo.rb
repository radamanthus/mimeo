require "mimeo/version"

module Mimeo
  module ClassMethods
    def ohm_model(model, options={})
      cattr_accessor :ohm_model_class, :field_map, :if_block

      self.ohm_model_class = model
      self.field_map = options[:field_map] if options[:field_map]

      self.set_callback :create, :after do
        self.save_to_redis
      end

      self.set_callback :save, :after do
        self.save_to_redis
      end

      self.set_callback :destroy, :after do
        self.remove_from_redis
      end
    end
  end

  module InstanceMethods
    def if_block_is_truthy
      if if_block
        if if_block.is_a? String
          eval if_block
        elsif if_block.is_a? Proc
          if_block.call
        end
      end
    end

    def remove_from_redis
      begin
        r = ohm_instance
        r.delete unless r.new?
      ensure
        return true
      end
    end

    def save_to_redis
      # If an :if option is given,
      # save to Redis only if the :if option evaluates to true
      if if_block_is_truthy
        begin
          r = ohm_instance
          populate(r).save
        ensure
          return true
        end
      else
        return true
      end
    end

    def ohm_instance
      ohm_model_class.find(rails_id: self.id).first || ohm_model_class.new
    end

    def populate(record)
      if field_map
        field_map.each do |ohm_field, rails_field|
          val = self.send(rails_field)
          record.send("#{ohm_field}=", val)
        end
      else
        self.class.accessible_attributes.to_a.reject{|a| a.blank?}.map{|a| a.to_sym}.each do |attr|
          val = self.send(attr)
          record.send("#{attr}=", val)
        end
      end
      record.rails_id = self.id
      record
    end
  end
end

ActiveRecord::Base.extend Mimeo::ClassMethods
ActiveRecord::Base.send(:include,  Mimeo::InstanceMethods)
