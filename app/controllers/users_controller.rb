class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  #helper_method :levelup
  #helper_method :leveldown

  def index
    p "main menu"
    p current_user.on_duty_cards
    p params
    @user = current_user
    @user.level = get_level_by_points
    @level_name = get_level_name
    if current_user.on_duty
      @player = Player.find_by("user_id == (?)", current_user.id)
      @game = Game.find_by("user_id == (?)", current_user.id)
      p @player
      p @game
    end
    @user.save!
  end

  def get_level_by_points
    case @user.points
    when 0..100
      0
    when 100..300
      1
    when 300.600
      2
    when 600..1000
      3
    else
      4
    end
  end

  def get_level_name
    case current_user.level.to_i
    when 0
      "鼠"
    when 1
      "猫"
    when 2
      "狗"
    when 3
      "猴"
    when 4
      "狼"
    when 5
      "豹"
    when 6
      "虎"
    when 7
      "狮"
    when 8
      "象"
    when 9
      "鲸"
    when 10
      "龙"
    when 11
      "人"
    else
      return "游客"
    end
  end

  def newbie
  end

  def ranking
  end

  def levelup
    @user = current_user
    p "up"
    @user.points += 99
    @user.save!
    redirect_to :root
  end

  def leveldown
    @user = current_user
    p "down"
    @user.points -= 99
    @user.save!
    redirect_to :root
  end

  def resetpoints
    @user = current_user
    @user.points = 0
    @user.save!
    redirect_to :root
  end
end
