# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oprah/version'

Gem::Specification.new do |gem|
  gem.name          = "oprah"
  gem.version       = Oprah::VERSION
  gem.authors       = ["Tobias Svensson"]
  gem.email         = ["tob@tobiassvensson.co.uk"]
  gem.summary       = "Opinionated presenters for Rails 5 - without the cruft"
  gem.description   = gem.summary
  gem.homepage      = "https://github.com/endofunky/oprah"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.has_rdoc = 'yard'

  #gem.add_dependency "activesupport", ">= 5.0.0"
  #gem.add_dependency "actionpack", ">= 5.0.0"

  gem.add_development_dependency "bundler", "~> 1.7"
  gem.add_development_dependency "minitest", "~> 5.9.0"
  #gem.add_development_dependency "rails", ">= 5.0.0"
  #gem.add_development_dependency "rake", "~> 10.0"
  #gem.add_development_dependency "redcarpet", "~> 3.3.4"
  #gem.add_development_dependency "yard", "~> 0.9.5"
  gem.add_development_dependency "sqlite3", "~> 1.3.11"
end
