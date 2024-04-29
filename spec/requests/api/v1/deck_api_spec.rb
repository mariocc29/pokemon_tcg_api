# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::DeckApi, type: :request do
  include Rack::Test::Methods

  describe 'GET /api/v1/decks' do
    subject do
      get "/api/v1/decks/", params
    end

    context 'with valid parameters' do
      let(:params) { { type: 'grass' } }

      it 'retrieves a list of decks' do
        expect(subject.status).to eq(HttpStatus::OK)
      end
    end

    context 'with invalid parameters' do
      let(:params) { { type: 'no-valid-type' } }

      it 'returns a bad request error' do
        expect(subject.status).to eq(HttpStatus::BAD_REQUEST)
      end
    end
  end
end