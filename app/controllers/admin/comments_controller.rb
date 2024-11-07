class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @comments = Comment.includes(:user, :post).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def search
    if params[:query].present?
      @comments = Comment.includes(:user, :post)
                         .where("content LIKE ?", "%#{params[:query]}%")
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(10)
    else
      @comments = Comment.includes(:user, :post).order(created_at: :desc).page(params[:page]).per(10)
    end
    render :index
  end

  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to edit_admin_comment_path(@comment), notice: '投稿を更新しました。'
    else
      render :edit
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'コメントが削除されました。'
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
