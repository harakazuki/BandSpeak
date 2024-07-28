class UsersController < ApplicationController
   before_action :authenticate_user!, only: [:edit, :update]
   before_action :guest, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end
  
  def likes
    @liked_posts = current_user.liked_posts
  end
  
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :bio)
  end
  
  def guest
    if current_user&.guest?
      redirect_to root_path, alert: 'ゲストユーザーはユーザー編集ページにアクセスできません。'
    end
  end
end
