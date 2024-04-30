# frozen_string_literal: true

module Pokemon
  module Cards
    # Process class responsible for handling cards of Pokemon Game.
    class Process

      # Initializes the Process with a specified type.
      # @param type [String] The type of cards to build
      def initialize(type)
        @type = type
      end

      # Builds a deck of Pokemon cards, energy cards, and trainer cards.
      # @return [Array] The built deck of cards
      def build
        total_cards = 60

        pokemon_cards = rand(12..16)
        energy_cards = 10
        trainer_cards = total_cards - energy_cards - pokemon_cards

        deck = []

        build_pokemon pokemon_cards do |cards|
          deck += mapping_cards(cards)
        end

        build_energy energy_cards do |cards|
          deck += mapping_cards(cards)
        end

        build_trainer trainer_cards do |cards|
          deck += mapping_cards(cards)
        end

        deck.shuffle!
        deck
      end

      private

      # Builds a specified number of Pokemon cards.
      # @param num_cards [Integer] The number of Pokemon cards to build
      def build_pokemon(num_cards)
        yield CardIndex.filter(bool: {
                                 must: [
                                   { term: { supertype: 'pokémon' } },
                                   { terms: { types: [@type] } },
                                   { function_score: {
                                     random_score: {}
                                   } }
                                 ]
                               }).limit(num_cards)
      end

      # Builds a specified number of energy cards.
      # @param num_cards [Integer] The number of energy cards to build
      def build_energy(num_cards)
        yield CardIndex.filter(bool: {
                                 must: [
                                   { term: { supertype: 'energy' } },
                                   { bool: {
                                     should: [
                                       { wildcard: { name: "*#{@type}*" } },
                                       { wildcard: { rules: "*#{@type}*" } }
                                     ]
                                   } },
                                   { function_score: {
                                     random_score: {}
                                   } }
                                 ]
                               }).limit(num_cards)
      end

      # Builds a specified number of trainer cards.
      # @param num_cards [Integer] The number of trainer cards to build
      def build_trainer(num_cards)
        yield CardIndex.filter(bool: {
                                 must: [
                                   { term: { supertype: 'trainer' } },
                                   { function_score: {
                                     random_score: {}
                                   } }
                                 ]
                               }).limit(num_cards)
      end

      # Maps card objects to a simplified format.
      # @param cards [Array] The array of card objects to map
      # @return [Array] The array of mapped cards
      def mapping_cards(cards)
        cards.map do |card|
          {
            "id": card.id,
            "name": card.name,
            "image": card.image
          }
        end
      end
    end
  end
end
