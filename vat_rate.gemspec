# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vat_rate/version'

Gem::Specification.new do |spec|
  spec.name          = 'vat_rate'
  spec.version       = VatRate::VERSION
  spec.authors       = ['Vojtech Kusy']
  spec.email         = ['vojta@inlinemanual.com']
  spec.summary       = %q{Simple VAT rates manager.}
  spec.description   = %q{Simple VAT rates manager originally developed as a client for http://jsonvat.com.}
  spec.homepage      = 'https://github.com/inlinemanual/vat_rate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
