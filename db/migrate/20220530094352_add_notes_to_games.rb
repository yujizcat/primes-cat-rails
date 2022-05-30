class AddNotesToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :notes, :text
  end
end
