class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :user
      t.references :game
      t.text :cards, array: true
      t.text :original_cards, array: true
      t.integer :powers
      t.text :current_history, array: true
      t.boolean :is_ai, default: false
      t.text :range, array: true
      t.integer :init_num_cards
      t.text :default_primes, array: true

      t.timestamps
    end
  end
end
