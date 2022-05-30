class AddCardsnameToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :cards_name_array, :text, array: true
  end
end
