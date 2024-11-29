class PostsController < ApplicationController
  def new
    # viewに渡すための空のmodelを作成
    @post = Post.new
  end
  
  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
end
