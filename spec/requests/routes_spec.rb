# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes', type: :request do
  include Rack::Test::Methods

  describe '403 Forbidden' do
    it 'returns a forbidden response for root route', :aggregate_failures do
      get '/'
      expect(last_response.status).to eq(HttpStatus::FORBIDDEN)
      expect(last_response.body).to include_json(
        {
          error: {
            code: HttpStatus::FORBIDDEN,
            message: '[ERR001] - You don\'t have the necessary permissions to access this resource.'
          }
        }
      )
    end
  end

  describe '404 Not Found' do
    it 'returns a not found response for undefined routes', :aggregate_failures do
      get '/undefined_route'
      expect(last_response.status).to eq(HttpStatus::NOT_FOUND)
      expect(last_response.body).to include_json(
        {
          error: {
            code: HttpStatus::NOT_FOUND,
            message: '[ERR002] - No route matches [GET] "/undefined_route"'
          }
        }
      )
    end
  end
end
