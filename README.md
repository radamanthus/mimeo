# Mimeo

This lets you easily call your Ohm model's save from within your Rails models after_save.

It creates an after_save callback insider your ActiveRecord model. The callback finds the matching Redis record and updates it with the content of the AR instance.
If a matching record is not found, a new one is created and saved.

All accessible attributes (attr_accessible) are used to populate the Redis record. There should be a one-to-one correspondence between the Rails and the Redis attribute names.

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

Inside your Ohm model, add:

    attribute :rails_id, Type::Integer
    index :rails_id

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
