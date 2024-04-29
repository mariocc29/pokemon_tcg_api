# frozen_string_literal: true

module V1
  module Serializers
    # Defines the structure for serializing holiday information.
    class DeckSerializer < Grape::Entity
      expose :label, documentation: { type: String, desc: 'Label or name of the deck.' }
      expose :type, documentation: { type: String, desc: 'The types of Pokémon included in the deck.' }
      expose :cards, documentation: { type: Array, desc: 'Array of cards in the deck.' } do |deck, options|
        deck[:cards].map do |card|
          {
            name: card[:name],
          }
        end
      end
    end
  end
end
