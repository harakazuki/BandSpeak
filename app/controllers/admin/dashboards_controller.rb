class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @user_count = User.count
    @post_count = Post.count
    @comment_count = Comment.count
  end
end
