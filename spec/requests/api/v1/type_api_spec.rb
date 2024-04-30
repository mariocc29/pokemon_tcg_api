# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TypeApi, type: :request do
  include Rack::Test::Methods

  describe 'GET /api/v1/types' do
    subject do
      get "/api/v1/types/"
    end

    it 'retrieves a list of decks', :aggregate_failures do
      response = subject
      expect(response.status).to eq(HttpStatus::OK)

      expected_result = %w[colorless darkness dragon fairy fighting fire grass lightning metal psychic water]
      expect(JSON.parse(response.body)).to match_array(expected_result)
    end
  end
end