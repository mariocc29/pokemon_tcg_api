# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class DeckApi < Grape::API
    version 'v1', using: :path

    resource :decks do
      desc 'Returns information pokemon deck api.',
           is_array: true
      get do
        []
      end
    end
  end
end
