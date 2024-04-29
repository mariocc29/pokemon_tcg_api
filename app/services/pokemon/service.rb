require 'uri'
require 'json'
require 'net/http'

module Pokemon
  # Service class responsible for making HTTP requests to the Pokemon API.
  class Service

    def initialize(endpoint)
      @uri = URI("#{Rails.application.config.pokemon[:url]}/#{endpoint}")
    end

    # Method to make a GET request to the API and parse the JSON response.
    def get
      response = connect do |http|
        request = Net::HTTP::Get.new @uri
        request['accept'] = 'application/json'
        http.request request
      end

      JSON.parse(response.read_body)
    end

    private

    def connect
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      yield http
    end
  end
end