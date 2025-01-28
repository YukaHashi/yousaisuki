class Admin::DashboardsController < ApplicationController
  layout 'admin'

  def index
    @users = User.all
    @posts = Post.all
  end
  
end
