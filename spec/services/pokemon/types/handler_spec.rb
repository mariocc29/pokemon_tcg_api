# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon::Types::Handler do
  describe('#get') do
    let(:process) { instance_double('Pokemon::Types::Process') }
    let(:expected_result) { %w[grass fire water] }

    before :each do
      allow(Pokemon::Types::Process).to receive(:new).and_return(process)
      allow(process).to receive(:build).and_return(expected_result)
    end

    it 'returns a list of a resource' do
      expect(described_class.get).to include_json(expected_result)
    end
  end
end
