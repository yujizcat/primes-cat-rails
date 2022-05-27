class Player < ApplicationRecord
  belongs_to :user
  has_many :games

  serialize :cards, Array
  serialize :original_cards, Array
  serialize :current_history, Array
  serialize :default_primes, Array
  serialize :range, Array
end
