require 'rubygems'
require 'bundler/setup'

Bundler.require

VatRate.configure do |config|
  config.store = VatRate::HttpStore.new('http://jsonvat.com')
end

puts VatRate.find('CZ').inspect
