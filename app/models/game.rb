class Game < ApplicationRecord
  belongs_to :player

  #extend FriendlyId
  #friendly_id :user_id, use: :slugged
  serialize :cards_name_array, Array
end
