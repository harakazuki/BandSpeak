class Admin::UsersController < ApplicationController
  layout 'admin'
  #before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(10)
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
