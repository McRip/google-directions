# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google-directions/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Moritz Kröger"]
  gem.email         = ["moritz.kroeger@googlemail.com"]
  gem.description   = "Wraps access to Google Directions API"
  gem.summary       = "Wraps access to Google Directions API"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "google-directions"
  gem.require_paths = ["lib"]
  gem.version       = GoogleDirections::VERSION

  gem.add_dependency "httparty", "~> 0.8.3"
  gem.add_dependency "polylines", "0.1.0"
  gem.add_dependency "multi_json", "1.3.6"
  gem.add_dependency "queryparams", "0.0.3"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "factory_girl"
end
