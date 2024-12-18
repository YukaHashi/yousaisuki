class PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  # 新規投稿
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
    # データを受け取り、更新する
    @post = Post.find(params[:id])
    # データを更新する
    if @post.update(post_params)
      flash[:notice] = "保存に成功しました"
      redirect_to post_path(@post.id)
    else
      # フラッシュメッセージを定義し、投稿編集edit.html.erbに遷移する
      flash.now[:notice] = "保存に失敗しました"
      render :edit
    end
  end
  
  def destroy
    # データを1件取得する
    @post = Post.find(params[:id])
    # データを削除する
    @post.destroy
    # 投稿一覧show.html.erbへ遷移する
    redirect_to posts_path
  end
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
  
   # 現在ログインしているユーザーのデータを取得し、一致していない場合は投稿一覧にリダイレクトする
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert] = "他のユーザーの投稿情報にアクセスする権限がありません"
      redirect_to post_path
    end
  end
  
end
