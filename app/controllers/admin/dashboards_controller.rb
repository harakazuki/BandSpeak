class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
      @users = User.page(params[:page]).per(10)
      @comments = Comment.page(params[:comment_page]).per(10)
  end
end
