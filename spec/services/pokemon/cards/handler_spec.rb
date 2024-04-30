# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon::Cards::Handler do
  describe('#get') do
    let(:type) { 'grass' }
    let(:process) { instance_double('Pokemon::Cards::Process') }
    let(:expected_result) do
      [{
        id: Faker::Alphanumeric.alpha(number: 10),
        name: Faker::Games::Pokemon.name,
        image: Faker::Internet.url(host: 'example.com', path: '/image.png')
      }]
    end

    before :each do
      allow(Pokemon::Cards::Process).to receive(:new).with(type).and_return(process)
      allow(process).to receive(:build).and_return(expected_result)
    end

    it 'returns a list of cards' do
      expect( described_class.get type ).to include_json(expected_result)
    end
  end
end
