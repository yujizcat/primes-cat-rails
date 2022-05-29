class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  #helper_method :levelup
  #helper_method :leveldown

  def index
    p "main menu"
    p params
    @level_name = get_level_name
    Game.where("user_id == (?)", current_user.id).delete_all
    Player.where("user_id == (?)", current_user.id).delete_all
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
    if @user.level < 11
      p "up"
      @user.level += 1
      @user.save!
      p @user.level
    end
    redirect_to :root
  end

  def leveldown
    @user = current_user
    if @user.level > 0
      p "down"
      @user.level -= 1
      @user.save!
      p @user.level
    end
    redirect_to :root
  end
end
