class AddSumroundToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :sumround, :integer
  end
end
