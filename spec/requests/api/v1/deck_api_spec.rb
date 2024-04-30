# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::DeckApi, type: :request do
  include Rack::Test::Methods

  shared_examples 'raises HttpStatus::BAD_REQUEST' do
    it 'returns a bad request error' do
      expect(subject.status).to eq(HttpStatus::BAD_REQUEST)
    end
  end

  describe 'GET /api/v1/decks' do
    subject do
      get "/api/v1/decks/", params
    end

    let!(:deck_grass) { create :deck, :with_type_grass }
    let!(:deck_fire) { create :deck, :with_type_fire }
    let!(:deck_water) { create :deck, :with_type_water }

    context 'without parameters' do
      let(:params) { {} }

      it 'retrieves a list of decks', :aggregate_failures do
        response = subject
        data = JSON.parse(response.body)
        expect(response.status).to eq(HttpStatus::OK)
        expect(data.length).to eq(3)
      end
    end

    context 'with valid parameters' do
      let(:params) { { category: 'grass' } }

      it 'retrieves a list of decks', :aggregate_failures do
        response = subject
        data = JSON.parse(response.body)
        expect(response.status).to eq(HttpStatus::OK)
        expect(data.length).to eq(1)
      end
    end

    context 'with invalid parameters' do
      let(:params) { { category: 'no-valid-type' } }
      it_behaves_like 'raises HttpStatus::BAD_REQUEST'
    end
  end

  describe 'POST /api/v1/decks' do
    subject do
      post "/api/v1/decks/", params
    end

    context 'with valid parameters' do
      let(:params) { { label:'my-deck', category: 'dragon' } }

      it 'creates a new deck', :aggregate_failures do
        response = subject
        expect(response.status).to eq(HttpStatus::CREATED)
        expect(Deck.all.count).to eql(1)
      end
    end

    context 'with invalid parameters' do
      context 'when label is not provided' do
        let(:params) { { category: 'dragon' } }
        it_behaves_like 'raises HttpStatus::BAD_REQUEST'
      end

      context 'when category is not provided' do
        let(:params) { { label:'my-deck' } }
        it_behaves_like 'raises HttpStatus::BAD_REQUEST'
      end

      context 'when category is invalid' do
        let(:params) { { label:'my-deck', category: 'no-valid-type' } }
        it_behaves_like 'raises HttpStatus::BAD_REQUEST'
      end
    end
  end
end