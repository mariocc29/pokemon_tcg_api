# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon::Types::Process do
  describe('#get') do
    subject { described_class.new(pokemon_service) }

    let(:pokemon_service) { instance_double('Pokemon::Service') }
    let(:expected_result) { %w[fairy darkness dragon] }

    context 'when data is in cache' do
      let(:cached_data) { %w[fairy darkness dragon] }
  
      before :each do
        allow(Rails.cache).to receive(:exist?).with('types').and_return(true)
        allow(Rails.cache).to receive(:read).with('types').and_return(cached_data)
      end
  
      it 'returns a list of types', :aggregate_failures do
        expect(subject.get).to match_array(expected_result)
        expect(subject).not_to receive(:fetch_data)
      end
    end

    context 'when data is not in cache' do
      let(:mock_response) { {'data': %w[Fairy Darkness Dragon]} }
  
      before :each do
        allow(pokemon_service).to receive(:endpoint=)
        allow(pokemon_service).to receive(:querystring=)
        allow(pokemon_service).to receive(:get).and_return(JSON.parse(mock_response.to_json))

        allow(Rails.cache).to receive(:exist?).with('types').and_return(false)
        allow(Rails.cache).to receive(:write)
      end
  
      it 'returns a list of types' do
        expect(subject.get).to match_array(expected_result)
      end
    end
  end
end
