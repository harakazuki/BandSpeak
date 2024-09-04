class Admin::PostsController < ApplicationController
  layout 'admin'
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: '投稿を更新しました。'
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :tag, :link)
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: '管理者としてログインしてください。'
    end
  end
end
