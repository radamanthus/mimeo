require "mimeo/version"

module Mimeo
  module ClassMethods
    def ohm_model(model, options = {})
      cattr_accessor :ohm_model_class, :ohm_model_index

      self.ohm_model_class = model
      self.ohm_model_index = options[:index]

      self.set_callback :save, :after do
        self.save_to_redis
      end
    end
  end

  module InstanceMethods
    def save_to_redis
      redis_record = get_redis_record(ohm_model_class, ohm_model_index)
      populate redis_record
      redis_record.save
      return true
    end

    def get_redis_record(model, index)
      model.find(rails_id: self.id).first || model.new
    end

    def populate(record)
      self.class.accessible_attributes.to_a.reject{|a| a.blank?}.map{|a| a.to_sym}.each do |attr|
        val = self.send(attr)
        record.send("#{attr}=", val)
        record.rails_id = self.id
      end
    end
  end
end

ActiveRecord::Base.extend Mimeo::ClassMethods
ActiveRecord::Base.send(:include,  Mimeo::InstanceMethods)
