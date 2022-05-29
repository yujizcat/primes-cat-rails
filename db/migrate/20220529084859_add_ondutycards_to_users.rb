class AddOndutycardsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :on_duty_cards, :text, array: true
  end
end
