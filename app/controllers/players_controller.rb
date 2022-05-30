require "prime"

class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:format].to_i)
  end

  def create
    puts "create player"
    @user = current_user
    @player = Player.new
    @player.user = current_user
    @player.user_id = current_user.id
    @player.cards = []
    @player.original_cards = []
    @player.current_history = []
    @player.is_ai = false
    @player.range = [determine_level[0], determine_level[1]]
    @player.init_num_cards = determine_level[2]
    @player.default_primes = Prime.each(@player.range[1].to_i).to_a.select { |x| x >= @player.range[0].to_i }.map { |x| x }
    @player.default_primes.compact!
    p @player
    @player.save!
    if @player.save!
      p "player saved"
      @user.on_duty = false
      @user.on_duty_cards = []
      @user.save!
      p @player
      redirect_to users_players_path(@player)
    else
      puts "error"
      render :new
    end
  end

  def determine_level_2
    case current_user.level.to_i
    when 0
      [0, 20, 3]
    when 1
      [0, 72, 3]
    when 2
      [0, 216, 3]
    when 3
      [72, 216, 3]
    when 4
      [0, 432, 3]
    when 5
      [72, 432, 3]
    when 6
      [216, 432, 3]
    when 7
      [0, 720, 3]
    when 8
      [72, 720, 3]
    when 9
      [216, 720, 3]
    when 10
      [432, 720, 3]
    when 11
      [0, 1080, 3]
    when 12
      [72, 1080, 3]
    when 13
      [216, 1080, 3]
    when 14
      [432, 1080, 3]
    when 15
      [720, 1080, 3]
    else
      [0, 20, 3]
    end
  end

  def determine_level
    num_cards = 3
    case current_user.level.to_i
    when 0
      [0, 30, 3]
    when 1..10
      [0, (current_user.level.to_i) * 100, num_cards]
    when 11
      [1000, 9999, num_cards]
    else
      [0, 50, num_cards]
    end
  end

  def determine_level_3
    # Set up player's default number of cards, range by level
    p "determine"
    each_max = [50, 100, 200, 500, 1000, 2000, 5000, 10000]
    num_cards = if current_user.level.to_i.odd? then 3 else 4 end
    case current_user.level.to_i
    when 0
      [0, 50, 3]
    when 1..28
      level_index = (current_user.level.to_i - 1) / 4
      [if current_user.level.to_i % 4 <= 2 && current_user.level.to_i % 4 != 0 then 0 else each_max[level_index] end, each_max[level_index + 1], num_cards]
    when 29
      [10000, 100000, 5]
    when 30
      [0, 1000000, 5]
    else
      [0, 50, 3]
    end
  end
end
