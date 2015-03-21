# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carendar/version'

Gem::Specification.new do |spec|
  spec.name          = "carendar"
  spec.version       = Carendar::VERSION
  spec.authors       = ["Axel Tetzlaff"]
  spec.email         = ["axel.tetzlaff@gmx.de"]
  spec.summary       = %q{Pure CSS week calendar rendering}
  spec.description   = %q{Provides a sass mixin and a rendering helper for simple display of calendar events.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
