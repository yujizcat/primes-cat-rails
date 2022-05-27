class Game < ApplicationRecord
  belongs_to :player

  #extend FriendlyId
  #friendly_id :user_id, use: :slugged
end
