# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/tilt/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-tilt"
  spec.version       = Rails::Tilt::VERSION
  spec.authors       = ["Łukasz Strzałkowski"]
  spec.email         = ["lukasz.strzalkowski@gmail.com"]
  spec.description   = %q{Use tilt for rendering templates}
  spec.summary       = %q{Use tilt for rendering templates}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "tilt", "~> 1.4.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
