# frozen_string_literal: true

class CreateDeckModels < ActiveRecord::Migration[7.1]
  def up
    create_table :decks do |t|
      t.string :label, null: false
      t.string :category, null: false
      t.json :cards, null: false

      t.timestamps
    end

    add_index :decks, :label, unique: true, name: 'deck_label_idx'
  end

  def down
    drop_table :decks
  end
end
