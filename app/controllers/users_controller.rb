class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def mypage
    @user = current_user
  end

  def edit
    @user = current_user
    puts "current_user id: #{current_user.id}"
    puts "@user id: #{@user.id}"
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts
  end
  
  def update
    # データを受け取り、更新する
    @user = User.find(params[:id])
    # データを更新する
    if @user.update(user_params)
      flash[:notice] = "保存に成功しました"
      redirect_to user_path(@user.id)
    else
      # フラッシュメッセージを定義し、ユーザー編集edit.html.erbに遷移する
      flash.now[:notice] = "保存に失敗しました"
      render :edit
    end
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
  

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
  
  # 現在ログインしているユーザーのデータを取得し、一致していない場合はマイページにリダイレクトする
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert] = "他のユーザーの情報にアクセスする権限がありません"
      redirect_to users_mypage_path
    end
  end

end
