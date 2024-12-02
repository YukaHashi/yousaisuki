class PostsController < ApplicationController
  def new
    # viewに渡すための空のmodelを作成
    @post = Post.new
  end
  
  # 投稿データの保存
  def create
    # データを受け取り、新規登録するためのインスタンス変数
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # データをデータベースに保存するためのsaveメソッド実行
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
      # フラッシュメッセージを定義し、new.html.erbを描画する
      flash.now[:notice] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
end
