require 'rails_helper'

RSpec.describe Deck, type: :model do
  
  describe 'validations' do
    let(:params) do
      {
        label: 'my-deck',
        category: 'grass'
      }
    end

    it { should validate_presence_of(:label) }
    it { should validate_presence_of(:category) }

    it 'validates uniqueness of label' do
      create(:deck, label: params[:label])
      deck = Deck.new(params)
      deck.valid?
      expect(deck.errors[:label]).to include('has already been taken')
    end
  end

  describe '#generate_random_deck' do
    let(:category) { 'grass' }
    let(:deck) { create(:deck, category: category) }
    let(:mock_response) do
      [
        {
          id: Faker::Alphanumeric.alpha(number: 10),
          name: Faker::Games::Pokemon.name,
          image: Faker::Internet.url(host: 'example.com', path: '/image.png')
        }
      ]
    end

    before do
      allow(Pokemon::Cards::Handler).to receive(:get).and_return(mock_response)
    end

    it 'sets the cards attribute using Pokemon::Cards::Handler' do
      deck.generate_random_deck
      expect(deck.cards).to include_json(mock_response)
    end
  end
end
