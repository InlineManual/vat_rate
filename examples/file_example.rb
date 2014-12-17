require 'rubygems'
require 'bundler/setup'

Bundler.require

VatRate.configure do |config|
  config.store = VatRate::FileStore.new(File.join(__dir__, 'file_example.json'))
end

puts VatRate.find('CZ').inspect
