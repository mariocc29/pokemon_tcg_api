# frozen_string_literal: true

module V1
  module Serializers
    # Defines the structure for serializing deck information.
    class DeckSerializer < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'Identifier of the deck.' }
      expose :label, documentation: { type: String, desc: 'Label or name of the deck.' }
      expose :category, documentation: { type: String, desc: 'The types of Pokémon included in the deck.' }
      expose :cards, documentation: { type: Array, desc: 'Array of cards in the deck.' } do |deck, options|
        deck.cards.map do |card|
          { image: card['image'] }
        end
      end
    end
  end
end
