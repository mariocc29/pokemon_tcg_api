# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonCardsIndexerJob, type: :job do
  describe('#perform') do
    let(:pokemon_service) { instance_double('Pokemon::Service') }
    let(:card_index) { class_double('CardIndex').as_stubbed_const }

    let(:mock_response) do
      {
        'data': [
          {
            'id': 1,
            'name': Faker::Games::Pokemon.name,
            'supertype': 'pokémon',
            'types': ['grass'],
            'rules': nil,
            'image': Faker::Internet.url(host: 'example.com', path: '/image.png')
          },
          {
            'id': 2,
            'name': Faker::Games::Pokemon.name,
            'supertype': 'pokémon',
            'types': ['grass'],
            'rules': nil,
            'image': Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        ],
        'totalCount' => 2,
        'count' => 1
      }
    end

    before do
      allow(card_index).to receive(:import)

      allow(Pokemon::Service).to receive(:instance).and_return(pokemon_service)
      allow(pokemon_service).to receive(:endpoint=)
      allow(pokemon_service).to receive(:querystring=)
      allow(pokemon_service).to receive(:get).and_return(mock_response)
    end

    it 'imports Pokemon card data' do
      expect(card_index).to receive(:import).with(mock_response['data'])
      described_class.perform_now
    end

    it 'enqueues subsequent jobs for remaining pages' do
      expect(described_class).to receive(:perform_later).with(2)
      described_class.perform_now
    end
  end
end
