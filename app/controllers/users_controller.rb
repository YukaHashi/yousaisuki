class UsersController < ApplicationController
  def mypage
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end