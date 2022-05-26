class PlayersController < ApplicationController
  # before_action :initialize

  def index
  end

  def show
  end

  def new
    @player = Player.new
    puts "aaa"
  end

  def create
    puts "create"
    @player.name = current_user.username
    @player.cards = []
    @player.original_cards = []
    @player.level = current_user.level
    @player.powers = 0
    @player.current_history = []
    @player.is_ai = false
    @player.range = [determine_level[0], determine_level[1]]
    @player.init_num_cards = determine_level[2]
    @player.default_primes = Prime.each(@range[1]).to_a.select { |x| x >= @range[0] }.map { |x| x }
    if @player.save
      redirect_to games_practice_path
    else
      puts "error"
      render :new
    end
  end

  def determine_level
    # Set up player's default number of cards, range by level
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
