class RemoveGameidFromPlayers < ActiveRecord::Migration[6.1]
  def change
    remove_column :players, :game_id, :string
  end
end
