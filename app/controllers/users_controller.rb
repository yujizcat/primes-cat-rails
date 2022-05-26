class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
    @level_name = get_level_name
  end

  def get_level_name
    case current_user.level.to_i
    when 0
      "小白"
    when 1
      "青铜☆"
    when 2
      "青铜☆☆"
    when 3
      "青铜☆☆☆"
    when 4
      "青铜★"
    when 5
      "白银☆"
    when 6
      "白银☆☆"
    when 7
      "白银☆☆☆"
    when 8
      "白银★"
    when 9
      "黄金☆"
    when 10
      "黄金☆☆"
    when 11
      "黄金☆☆☆"
    when 12
      "黄金★"
    when 13
      "铂金☆"
    when 14
      "铂金☆☆"
    when 15
      "铂金☆☆☆"
    when 16
      "铂金★"
    when 17
      "钻石☆"
    when 18
      "钻石☆☆"
    when 19
      "钻石☆☆☆"
    when 20
      "钻石★"
    when 21
      "星耀☆"
    when 22
      "星耀☆☆"
    when 23
      "星耀☆☆☆"
    when 24
      "星耀★"
    when 25
      "黄金王者"
    when 26
      "铂金王者"
    when 27
      "钻石王者"
    when 28
      "星耀王者"
    when 29
      "传奇王者"
    when 30
      "创世神"
    else
      return "游客"
    end
  end

  def newbie
  end

  def ranking
  end

  private

  #def set_user
  #  @user = User.find(params[:id])
  #end

  #def user_params
  #  params.require(:user).permit(:username, :email, :level, :points)
  #end
end
