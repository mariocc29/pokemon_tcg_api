# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'
require 'singleton'

module Pokemon
  # Service class responsible for making HTTP requests to the Pokemon API.
  class Service
    include Singleton

    attr_accessor :endpoint, :querystring

    # Method to make a GET request to the API and parse the JSON response.
    def get
      uri = build_uri

      response = connect uri do |http|
        request = Net::HTTP::Get.new uri
        request['accept'] = 'application/json'
        http.request request
      end

      JSON.parse(response.read_body)
    end

    private

    # Builds the URI for the API request based on the endpoint and query string.
    def build_uri
      URI("#{Rails.application.config.pokemon[:url]}/#{@endpoint}/?#{@querystring}")
    end

    # Establishes an HTTP connection and yields for further action.
    def connect(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      yield http
    end
  end
end
