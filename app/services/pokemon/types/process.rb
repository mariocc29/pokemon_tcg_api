# frozen_string_literal: true

module Pokemon
  module Types
    class Process < Pokemon::Service

      def initialize
        super('types')
      end

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
