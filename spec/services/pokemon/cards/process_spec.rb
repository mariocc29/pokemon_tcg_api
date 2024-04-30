# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon::Cards::Process do
  describe('#build') do
    subject { described_class.new(type) }

    let(:type) { 'grass' }
    let(:mock_api_response) do
      [
        {
          id: 1,
          name: 'Bulbasaur',
          supertype: 'pokémon',
          types: ['grass'],
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
        {
          id: 2,
          name: 'Squirtle',
          supertype: 'pokémon',
          types: ['water'],
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
        {
          id: 3,
          name: 'Grass Energy',
          supertype: 'energy',
          types: ['grass'],
          rules: nil,
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
        {
          id: 4,
          name: 'Herbal Energy',
          supertype: 'energy',
          rules: ['Herbal Energy provides Grass Energy.'],
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
        {
          id: 5,
          name: 'Holon Energy WP',
          supertype: 'energy',
          rules: ['Holon Energy WP provides Colorless Energy.'],
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
        {
          id: 6,
          name: 'Tropical Wind',
          supertype: 'trainer',
          rules: [ Faker::Lorem.sentence ],
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
        {
          id: 7,
          name: 'Pokémon Fan Club',
          supertype: 'trainer',
          rules: [ Faker::Lorem.sentence ],
          images: { 
            large: Faker::Internet.url(host: 'example.com', path: '/image.png')
          }
        },
      ]
    end

    before do
      CardIndex.reset!
      CardIndex.import(JSON.parse(mock_api_response.to_json))
    end

    it 'return a deck' do
      expected_cards = [
        {id: 1, name: "Bulbasaur", image: "http://example.com/image.png"}, 
        {id: 3, name: "Grass Energy", image: "http://example.com/image.png"}, 
        {id: 4, name: "Herbal Energy", image: "http://example.com/image.png"}, 
        {id: 6, name: "Tropical Wind", image: "http://example.com/image.png"}, 
        {id: 7, name: "Pokémon Fan Club", image: "http://example.com/image.png"}
      ]
      
      expect(subject.build).to match_array(expected_cards)
    end
  end
end