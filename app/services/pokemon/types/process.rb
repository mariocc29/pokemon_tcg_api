# frozen_string_literal: true

module Pokemon
  module Types
    # Process class responsible for handling types of Pokemon.
    class Process
      # Initializes the Process with a Pokemon service and a Redis key.
      # @param pokemon_service [Pokemon::Service] The service for fetching Pokemon data
      def initialize(pokemon_service)
        @pokemon_service = pokemon_service
        @redis_key = 'types'
      end

      # Retrieves types of Pokemon from the cache if available, otherwise fetches and caches them.
      # @return [Array<String>] An array of Pokemon types
      def get
        return Rails.cache.read(@redis_key) if Rails.cache.exist?(@redis_key)

        data = fetch_data.map(&:downcase)
        Rails.cache.write(@redis_key, data, expires_in: 1.day) if data
        data
      end

      private

      attr_reader :pokemon_service, :redis_key

      # Fetches Pokemon types data from the Pokemon service.
      # @return [Array<String>] An array of Pokemon types
      def fetch_data
        @pokemon_service.endpoint = 'types'
        @pokemon_service.querystring = ''
        @pokemon_service.get['data']
      end
    end
  end
end
