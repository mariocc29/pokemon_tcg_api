# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class TypeApi < Grape::API
    version 'v1', using: :path

    resource :types do
      desc 'Returns information about types of the pokemons.',
           is_array: true,
           success: Serializers::TypeSerializer,
           failure: []
      get do
        types = Pokemon::Types::Handler.get
        present types, with: Serializers::TypeSerializer
      end
    end
  end
end
