class AddLevelpointsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :level, :string, default: 0
    add_column :users, :points, :string, default: 0
  end
end
