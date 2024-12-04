class UsersController < ApplicationController
  def mypage
    @user = current_user
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
    redirect_to user_path(@user.id)
  end
  
  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueにupdateにして退会状態にする
    @user.update(is_deleted: true)
    # セッション情報を全て削除
    reset_session
    flash[:notice] = "退会処理を実行しました"
    # 退会後トップ画面に遷移する
    redirect_to root_path
  end
  
  # is_deletedがfalseならtrueを返すように
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
