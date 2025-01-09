class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @post = Post.new
    @groups = Group.all
    @user = User.find(current_user.id)
  end
  
  def show
    @post = Post.new
    @group = Group.find(params[:id])
    @user = User.find(params[:id])
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    #グループ作成者が誰かを判断する
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
  
  # params[:id]を持つ@groupのowner_idカラムのデータと自分のuser_idが一緒かを確かめる
  # 違う場合、グループ一覧画面に遷移する
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
