class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :level, :integer
    add_column :users, :points, :integer
  end
end
