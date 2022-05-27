class Player < ApplicationRecord
  belongs_to :user
  has_many :games

  serialize :cards, Array
  serialize :original_cards, Array
  serialize :current_history, Array
  serialize :default_primes, Array
  serialize :range, Array

  #extend FriendlyId
  #friendly_id :user_id, use: :slugged

  def set_original_card
    @original_cards = @cards.clone
  end

  def get_cards
    sort_cards
    return @cards
  end

  def get_cards_average
    if @cards.size > 0
      return @cards.sum / @cards.size
    else
      return 0
    end
  end

  def change_cards(new_cards)
    @cards = new_cards
  end
end
