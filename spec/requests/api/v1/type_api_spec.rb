# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TypeApi, type: :request do
  include Rack::Test::Methods

  describe 'GET /api/v1/types' do
    subject do
      get "/api/v1/types/"
    end

    it 'retrieves a list of decks' do
      expect(subject.status).to eq(HttpStatus::OK)
    end
  end
end