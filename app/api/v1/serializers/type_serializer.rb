# frozen_string_literal: true

module V1
  module Serializers
    # Defines the structure for serializing holiday information.
    class TypeSerializer < Grape::Entity
      expose :label, documentation: { type: String, desc: 'Label or name of the Pokemon types.' }
    end
  end
end
