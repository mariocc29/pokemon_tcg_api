# frozen_string_literal: true

module V1
  # Version: 1
  # This class represents the API for handling endpoints.
  class TypeApi < Grape::API
    version 'v1', using: :path

    resource :types do
      desc 'Returns information about types of the pokemons.',
           is_array: true,
           success: { code: 200, message: 'Array of pokemon types' },
           failure: []
      get do
        Pokemon::Types::Handler.get
      end
    end
  end
end
