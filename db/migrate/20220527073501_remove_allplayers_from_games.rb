class RemoveAllplayersFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :all_players, :string
  end
end
