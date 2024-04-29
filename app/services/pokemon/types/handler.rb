# frozen_string_literal: true

module Pokemon
  module Types
    # Handler class responsible for retrieving types of Pokemon.
    class Handler

      # Method to retrieve Pokemon types.
      def self.get
        process = Pokemon::Types::Process.new()
        process.build
      end
    end
  end
end
