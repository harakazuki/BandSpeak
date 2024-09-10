class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.includes(:user, :post).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'コメントが削除されました。'
  end
    
  private
  def authenticate_admin!
    unless current_user&.admin?
    redirect_to root_path, alert: '管理者としてログインしてください。'
    end
  end
end
