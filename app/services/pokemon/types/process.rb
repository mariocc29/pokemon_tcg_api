# frozen_string_literal: true

module Pokemon
  module Types
    class Process < Pokemon::Service

      def initialize
        super('types')
      end

      def build
        get['data'].map do |type|
          { 'label': type.downcase }
        end
      end
    end
  end
end
