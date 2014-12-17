require 'set'

module VatRate
  class Rate

    include Comparable

    attr_accessor :name, :code, :type, :effective_from, :effective_to, :rate

    def initialize(attrs={})
      attrs.each_pair do |k, v|
        send("#{k}=", v)
      end
    end

    def time_match?(time)
      time > effective_from && (effective_to.nil? || effective_time < effective_to)
    end

    def <=>(other)
      return  0 if rate == other.rate
      return  1 if rate > other.rate
      return -1 if rate < other.rate
    end

  end
end
