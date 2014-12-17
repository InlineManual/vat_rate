require 'vat_rate/version'
require 'vat_rate/http_store'
require 'vat_rate/file_store'
require 'vat_rate/rate'
require 'vat_rate/list'

module VatRate

  class NotFound < StandardError; end

  class Configuration
    attr_accessor :store

    def initialize
      @store = HttpStore.new('http://jsonvat.com')
    end
  end

  class << self
    attr_writer :configuration, :list
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.list
    @list ||= List.new(configuration)
  end

  def self.find(code, type: 'standard', at: Time.now)
    list.find(code, type: type, at: at)
  end

  def self.all
    list.all
  end

end
