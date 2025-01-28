class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all
    @users = User.all
  end
  
  def destroy
    # データを1件取得する
    @post = Post.find(params[:id])
    # データを削除する
    @post.destroy
    # 投稿一覧へ遷移する
    redirect_to admin_posts_path
  end
end
