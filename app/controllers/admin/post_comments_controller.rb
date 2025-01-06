class Admin::PostCommentsController < ApplicationController
  
  def index
    # すべての投稿データを受け取る
    @post_comments = PostComment.all
    # すべてのユーザーデータを受け取る
    @users = User.all
  end
  
  def destroy
    # データを1件取得する
    @post_comment = PostComment.find(params[:id])
    # データを削除する
    @post_comment.destroy
    # 投稿一覧へ遷移する
    redirect_to admin_post_comments_path
  end
  
end
