# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kojn/version'

Gem::Specification.new do |spec|
  spec.name          = "kojn"
  spec.version       = Kojn::VERSION
  spec.authors       = ["Jeffrey Wilcke", "Maran Hidskes"]
  spec.email         = ["maran.hidskes@gmail.com", "jeff.wilcke@gmail.com"]
  spec.description   = %q{Ruby gem for communicating with the kojn.nl API. Allows you to create and managed invoices.}
  spec.summary       = %q{Ruby gem for communicating with the kojn.nl API.}
  spec.homepage      = "https://kojn.nl"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activemodel"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency 'curb', '> 0.8.1'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
