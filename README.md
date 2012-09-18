# Mimeo

This is a gem to let you easily access your Ohm models from within your Rails models after_save.

It creates an after_save callback insider your ActiveRecord model. The callback finds the matching Redis record and updates it with the content of the AR instance.
If a matching record is not found, a new one is created and saved.

All accessible attributes (attr_accessible) are used to populate the Redis record. There should be a one-to-one correspondence between the Rails and the Redis attribute names.
If :field_map is specified in the options, then only those in the field_map hash are used to populate the Redis record.

It also adds an ohm_instance convenience method into the ActiveRecord instance.

## Installation

Add this line to your application's Gemfile:

    gem 'mimeo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mimeo

## Usage

Inside your ActiveRecord model, add:

    ohm_model <ModelName>

where ModelName is the name of your Ohm model.

If you want to customize the field mapping:

    ohm_model <ModelName>,
      field_map: {
        active_record_attr1: :ohm_model_attr1,
        active_record_attr2: :ohm_model_attr2
        ...
      }

Inside your Ohm model, add:

    attribute :rails_id, Type::Integer
    index :rails_id

Once setup, your ActiveRecord model instances have access to the corresponding Ohm record, like so:

    user = User.find(1)
    puts user.ohm_instance.ohm_instance_attribute

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
