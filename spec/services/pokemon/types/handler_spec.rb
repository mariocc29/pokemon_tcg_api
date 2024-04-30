# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon::Types::Handler do
  describe('#get') do
    let(:pokemon_service) { instance_double('Pokemon::Service') }
    let(:process) { instance_double('Pokemon::Types::Process') }
    let(:expected_result) { %w[grass fire water] }

    before :each do
      allow(Pokemon::Service).to receive(:instance).and_return(pokemon_service)

      allow(Pokemon::Types::Process).to receive(:new).with(pokemon_service).and_return(process)
      allow(process).to receive(:get).and_return(expected_result)
    end

    it 'returns a list of the Pokemon types' do
      expect(described_class.get).to include_json(expected_result)
    end
  end
end
