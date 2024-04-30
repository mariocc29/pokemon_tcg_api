# frozen_string_literal: true

module Pokemon
  module Cards
    # Handler class responsible for retrieving the cards of Pokemon Game.
    class Handler
      # Retrieves cards of a specified type using the Pokemon::Cards::Process class.
      # @param type [String] The type of cards to retrieve
      # @return [Array] An array of cards
      def self.get(type)
        process = Pokemon::Cards::Process.new(type)
        process.build
      end
    end
  end
end
