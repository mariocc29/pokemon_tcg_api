# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon::Types::Process do
  describe('#build') do
    subject { described_class.new }

    context 'when data is in cache' do
      let(:api_response) { {'data': %w[Grass Fire Water]} }
      let(:cached_data) { %w[fairy darkness dragon] }
  
      before :each do
        allow_any_instance_of(Pokemon::Service).to receive(:get).and_return( JSON.parse(api_response.to_json) )
        allow(Rails.cache).to receive(:exist?).with('types').and_return(true)
        allow(Rails.cache).to receive(:read).with('types').and_return(cached_data)
      end
  
      it 'returns a list of types' do
        expect(subject.build[0]).to eql('fairy')
        expect(subject.build[1]).to eql('darkness')
        expect(subject.build[2]).to eql('dragon')
      end
    end
    
    context 'when data is not in cache' do
      let(:api_response) { {'data': %w[Grass Fire Water]} }
  
      before :each do
        allow_any_instance_of(Pokemon::Service).to receive(:get).and_return( JSON.parse(api_response.to_json) )
        allow(Rails.cache).to receive(:exist?).with('types').and_return(false)
        allow(Rails.cache).to receive(:write)
      end
  
      it 'returns a list of types' do
        expect(subject.build[0]).to eql('grass')
        expect(subject.build[1]).to eql('fire')
        expect(subject.build[2]).to eql('water')
      end
    end
  end
end
