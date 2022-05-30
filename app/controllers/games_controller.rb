class GamesController < ApplicationController
  # before_action :set_player
  before_action :initialize, only: [:show]
  helper_method :say

  def index
  end

  def create
    puts "create_game"
    @user = current_user
    @player = Player.find(params[:player_id])
    @game = Game.new

    @game.user_id = current_user.id
    @game.round = 1
    @game.current_action = ""
    @game.current_possibles = []
    @game.game_over = false
    @game.player = set_up(@player)
    @player.original_cards = @player.cards.clone
    p "original"
    # p @player.original_cards
    @player.current_history << @player.original_cards
    @player.save!
    @game.save!
    if @game.save!
      p "game saved"
      @user.on_duty = true
      @user.on_duty_cards = @player.original_cards
      @user.save!
      redirect_to games_challenge_path(@game)
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

    p "set up names"
    file = File.open("db/all_names.txt")
    file_data = file.read.split(" ")
    file_data.each_slice(2) do |i, n|
      #p "#{i} #{n}"
      @game.cards_name_array << n
    end

    # p @game.cards_name_array

    p "ccccc"
    p player.init_num_cards
    p player
    p player.cards
    player.cards.sort!

    player.set_original_card
    return player
  end

  def select
    puts "select"
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

  def add_cards
    p "addeee"

    p params[:my_action]
    input = params[:my_action].split(" ")
    @user = current_user
    @player = Player.find(params[:player_id])
    @game = Game.find(params[:game_id])

    new_value = input[0].to_i + input[1].to_i
    @player.cards.flatten!
    @player.cards.push(new_value.to_i)
    @player.save!
    p @player.cards
    auto_reduce_fraction
    auto_reduce_fraction
    @game.current_action = ""
    @player.current_history << @player.cards

    @game.round += 1
    @game.save!
    @player.save!

    check_game_over

    @user.on_duty_cards = @player.cards
    @user.save!

    redirect_back fallback_location: root_path
  end

  def auto_reduce_fraction
    gcd_found = false
    common_number = false
    change_index = [-1, -1]

    @player.cards.each_with_index do |x, i|
      @player.cards.each_with_index do |y, j|
        break if gcd_found == true
        if x != y
          unless (x == 1) || (y == 1)
            if x.gcd(y) != 1
              @player.cards[i] /= x.gcd(y)
              @player.cards[j] /= x.gcd(y)
              gcd_found = true
            end
          end
        else
          if i != j
            change_index = [i, j]
            common_number = true
            gcd_found = true
          end
        end
      end
    end
    if common_number
      @player.cards.delete_at(change_index[1])
      @player.cards.delete_at(change_index[0])
    end
    @player.cards.delete(1) if @player.cards.include?(1)
    @player.cards.sort!
    @player.save!
  end

  def check_game_over
    if @player.cards.size <= 2
      puts "game over"
      @player.cards = []
      @player.save!
      @game.game_over = true
      @game.save!
    end
  end

  def challenge
    puts "start challenge"
    p params
    @game = Game.find(params[:format].to_i)
    p @game
    p @game.player
  end

  def calculate_points
    points = (@player.original_cards.sum) ** 1.1 / 2
    return points.to_i
  end

  def win
    p "You win"
    @user = current_user
    @game = Game.find(params[:game_id].to_i)
    @player = Player.find(params[:player_id])
    @final_points = calculate_points
    @user.points += @final_points
    @user.on_duty = false
    @user.on_duty_cards = []
    @user.save!
    Game.where("user_id == (?)", current_user.id).delete_all
    Player.where("user_id == (?)", current_user.id).delete_all
  end

  def lose
    p "You lose"
    @user = current_user
    @game = Game.find(params[:game_id].to_i)
    @player = Player.find(params[:player_id])
    @final_points = calculate_points
    @user.points -= @final_points / 4
    @user.on_duty = false
    @user.on_duty_cards = []
    @user.save!
    Game.where("user_id == (?)", current_user.id).delete_all
    Player.where("user_id == (?)", current_user.id).delete_all
  end

  def backtomain
    p "back to main"
    redirect_to :root
  end
end
