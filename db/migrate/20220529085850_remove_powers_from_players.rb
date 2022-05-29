class RemovePowersFromPlayers < ActiveRecord::Migration[6.1]
  def change
    remove_column :players, :powers, :string
  end
end
