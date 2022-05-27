class GamesController < ApplicationController
  # before_action :set_player
  before_action :initialize, only: [:show]

  def index
  end

  def create
    puts "create_game"
    @player = Player.find(params[:player_id])
    @game = Game.new
    @game.round = 1
    @game.current_action = ""
    @game.current_possibles = []
    @game.game_over = false
    @game.player = set_up(@player)
    @player.save!
    @game.save!
    if @game.save!
      p "game saved"
      redirect_to games_practice_path(@game)
    else
      puts "error"
      render :new
    end
  end

  def set_up(player)
    player.default_primes.compact!
    [*1..player.init_num_cards].each do |i|
      player.cards << player.default_primes.delete(player.default_primes.sample)
    end
    p "ccccc"
    p player.init_num_cards
    p player
    p player.cards
    player.cards.sort!

    # player.set_init_powers
    player.set_original_card
    return player
  end

  def practice
    puts "bbb practice"
    @game = Game.find(params[:format].to_i)
    p @game
    p @game.player
  end

  def challenge
  end

  def game
  end
end
