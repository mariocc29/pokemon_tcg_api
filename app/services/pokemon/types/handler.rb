# frozen_string_literal: true

module Pokemon
  module Types
    class Handler
      def self.get
        process = Pokemon::Types::Process.new()
        process.build
      end
    end
  end
end
