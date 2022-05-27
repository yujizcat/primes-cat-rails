class GamesController < ApplicationController
  # before_action :set_player
  before_action :initialize, only: [:show]

  def index
  end

  def create
    puts "create_game"
    @player = Player.find(params[:id])
    @game = Game.new
    @game.player = @player
    @game.round = 1
    @game.current_action = ""
    @game.current_possibles = []
    @game.game_over = false
    @game.save!
    if @game.save!
      p "game saved"
      redirect_to games_practice_path
    else
      puts "error"
      render :new
    end
  end

  def practice
    puts "bbb"
    @player = Player.find(params[:id])
  end

  def challenge
  end

  def game
  end
end
