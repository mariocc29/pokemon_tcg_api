# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class DeckApi < Grape::API
    version 'v1', using: :path

    resource :decks do
      desc 'Returns information pokemon deck api.',
           is_array: true,
           success: Serializers::DeckSerializer,
           failure: [
            ApplicationException::BadRequestException.to_h,
           ]
      params do
        optional :category, type: String, values: Pokemon::Types::Handler.get, desc: 'The category by which you want to filter decks.'
      end
      get do
        decks = Deck.all
        present decks, with: Serializers::DeckSerializer
      end

      desc 'Create a new deck.',
        success: Serializers::DeckSerializer,
        failure: [
          ApplicationException::BadRequestException.to_h,
        ]
      params do
        requires :label, type: String, desc: 'The label of the deck'
        requires :category, type: String, values: Pokemon::Types::Handler.get, desc: 'The category of the deck'
      end
      post do
        deck = Deck.new(label: params[:label], category: params[:category])
        deck.save
        
        present deck, with: Serializers::DeckSerializer
      end
    end
  end
end
