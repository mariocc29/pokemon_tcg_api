# frozen_string_literal: true

module Pokemon
  module Types
    # Process class responsible for handling types of Pokemon.
    class Process < Pokemon::Service

      def initialize
        super('types')
      end

      # Builds and retrieves the types of Pokemon.
      def build
        redis_key = 'types'
        return Rails.cache.read(redis_key) if Rails.cache.exist?(redis_key)

        data = get['data'].map { |type| type.downcase }
        Rails.cache.write(redis_key, data, expires_in: 1.day) if data
        data
      end
    end
  end
end
