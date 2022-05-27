class AddSlugToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :slug, :string
    add_index :games, :slug, unique: true
  end
end
