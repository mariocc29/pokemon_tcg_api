# frozen_string_literal: true

# CardIndex class representing an index of Pokemon cards
class CardIndex < Chewy::Index
  field :id, type: 'keyword'
  field :name, type: 'text'
  field :supertype, type: 'text'
  field :types
  field :rules
  field :image, value: ->(card) { card['images']['large'] }
end
