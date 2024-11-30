class UsersController < ApplicationController
  def mypage
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts
  end
end
