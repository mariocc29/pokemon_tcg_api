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
        optional :type, type: String, values: ['grass', 'fire', 'water'], desc: 'The type by which you want to filter decks.'
      end
      get do
        decks = []
        present decks, with: Serializers::DeckSerializer
      end
    end
  end
end
