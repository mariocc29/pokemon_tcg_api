# frozen_string_literal: true

class Deck < ApplicationRecord
  
  validates :label, presence: true, uniqueness: true
  validates :category, presence: true

  before_create :generate_random_deck

  # Generates a random deck using the Pokémon Cards Handler
  def generate_random_deck
    self.cards = Pokemon::Cards::Handler.get self.category
  end
end
