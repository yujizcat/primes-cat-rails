class GamesController < ApplicationController
  # before_action :set_player
  before_action :initialize, only: [:show]
  helper_method :say

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

  def select
    puts "say"
    @player = Player.find(params[:player_id])
    @game = Game.find(params[:game_id])
    if @game.current_action.split(" ").include?(params[:selected_number])
      p params[:selected_number]
      p "already included"
      temp = @game.current_action.split(" ").reject { |x| x == params[:selected_number] }
      p temp
      if temp == []
        p "set 0"
        @game.current_action = ""
        p @game.current_action
      else
        p "decrease"
        @game.current_action = temp.join(" ")
        p @game.current_action
      end
    else
      if @game.current_action.split(" ").size < 2
        p "not included yet, size < 2"
        @game.current_action += " "
        @game.current_action += @player.cards[params[:index].to_i].to_s
        @game.current_action += " "
      else
        p "size > 2"
        temp = @game.current_action.split(" ").drop(1)
        temp << @player.cards[params[:index].to_i].to_s
        @game.current_action = temp.join(" ")
        p @game.current_action
      end
    end

    p @game.current_action.split(" ")
    p @game.current_action

    @game.save!

    # @player.save!
    puts params[:format].to_i
    # redirect_to games_practice_path
    redirect_back fallback_location: root_path
  end

  def practice
    puts "bbb practice"
    p params
    @game = Game.find(params[:format].to_i)
    p @game
    p @game.player
  end

  def challenge
  end

  def game
  end
end
