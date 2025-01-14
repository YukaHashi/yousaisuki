class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    # 現在のユーザーを取得し、新しいレコードを作成
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    # 前にいたページに遷移
    redirect_to request.referer
  end
  
  def destroy
    # ログインしているユーザーのgroup_users関連付けを使用し、指定されたグループに関連付けられたgroup_userインスタンスをfind_byメソッドで検索
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    # 前にいたページに遷移
    redirect_to request.referer
  end
  
end
