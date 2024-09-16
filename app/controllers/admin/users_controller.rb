class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_admin_user_path(@user), notice: '投稿を更新しました。'
    else
      render :edit
    end
    
  end
  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end
    
  private
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: '管理者としてログインしてください。'
    end
  end
end
