class RemoveLpFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :level, :string
    remove_column :users, :points, :string
  end
end
