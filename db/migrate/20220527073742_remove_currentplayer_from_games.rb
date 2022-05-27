class RemoveCurrentplayerFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :current_player, :string
  end
end
