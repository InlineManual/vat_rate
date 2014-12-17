require 'net/http'
require 'uri'

module VatRate
  class HttpStore

    def initialize(uri)
      @uri = uri
    end

    def read
      uri = URI.parse(@uri)
      response = Net::HTTP.get_response(uri)
      response.body
    end

  end
end
