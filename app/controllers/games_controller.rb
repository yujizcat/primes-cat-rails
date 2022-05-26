class GamesController < ApplicationController
  # before_action :set_player
  before_action :initialize, only: [:show]

  def index
  end

  def practice
    puts "bbb"
    @player = Player.new
  end

  def challenge
  end
end
