require 'set'
require 'json'

module VatRate
  class List

    def initialize(config)
      @store = config.store
    end

    def find(code, type: 'standard', at: Time.now)
      rate = all.find { |r| r.code == code && r.type == type && r.time_match?(at) }
      raise NotFound, "No VAT rate was found for country: #{code}, type: #{type}, at: #{at}" unless rate
      rate
    end

    def all
      @vat_rates = load_from_store unless defined? @vat_rates
      @vat_rates
    end

    def from_json(data)
      json = JSON.parse(data)
      load(json['rates'])
    end

    def load_from_store
      data = store.read
      from_json(data)
    end

    def load(rates)
      @vat_rates = rates.each_with_object(Set.new) do |country, set|
        periods = country['periods'].sort { |a,b| a['effective_from'] <=> b['effective_from'] }
        periods_enum = periods.to_enum
        begin
          while period = periods_enum.next do
            next_period =
              begin
                periods_enum.peek
              rescue StopIteration
                Hash.new
              end

            period['rates'].each_pair do |type, rate|
              vat = Rate.new
              vat.name = country['name']
              vat.code = country['code']
              vat.type = type
              vat.rate = rate
              vat.effective_from = Time.parse(period['effective_from'])
              vat.effective_to   = Time.parse(next_period['effective_from']) if next_period['effective_from']

              set << vat.freeze
            end
          end
        rescue StopIteration
        end
      end
    end

  protected

    attr_reader :store

  end
end
