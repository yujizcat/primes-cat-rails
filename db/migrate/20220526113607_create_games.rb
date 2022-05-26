class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.text :all_players, array: true
      t.text :current_player, array: true
      t.integer :round
      t.string :current_action
      t.text :current_possibles, array: true
      t.boolean :game_over, default: false

      t.timestamps
    end
  end
end
