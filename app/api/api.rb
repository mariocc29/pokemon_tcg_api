# frozen_string_literal: true

# This class represents the main API combining multiple versions.
class Api < Grape::API
  include ExceptionHandlers

  format :json

  mount V1::DeckApi

  # Endpoint for health check, used to verify the API's operational status.
  # Returns a JSON response with a 'health' key set to 'ok' if the API is functioning properly.
  desc 'Endpoint for health check, used to verify the API\'s operational status.'
  get :health do
    { health: 'ok' }
  end
end
