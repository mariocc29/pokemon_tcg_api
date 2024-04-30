# frozen_string_literal: true

module Pokemon
  module Types
    # Handler class responsible for retrieving types of Pokemon.
    class Handler
      # Method to retrieve Pokemon types
      # @return [Array] An array of Pokemon types
      def self.get
        pokemon_service = Pokemon::Service.instance

        process = Pokemon::Types::Process.new(pokemon_service)
        process.get
      end
    end
  end
end
