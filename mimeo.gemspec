# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mimeo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Radamanthus Batnag"]
  gem.email         = ["radamanthus@gmail.com"]
  gem.description   = %q{ActiveRecord extension for saving data to Redis using a given Ohm model.}
  gem.summary       = %q{
    This is an ActiveRecord extension for saving data to Redis using a given Ohm model. I will give more details when I have more time.
  }
  gem.homepage      = "http://radamanthus.github.com/mimeo"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mimeo"
  gem.require_paths = ["lib"]
  gem.version       = Mimeo::VERSION
end
