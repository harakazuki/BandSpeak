class LikesController < ApplicationController
  before_action :find_post

  def like
    @posts = current_user.liked_posts.page(params[:page]).per(5)
  end

  def create
    @post.likes.create(user_id: current_user.id)
    flash[:notice] = "イイねしました。"
    redirect_to post_path(@post)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "イイねを解除できませんでした。"
    else
      @like = @post.likes.find_by(user_id: current_user.id)
      @like.destroy
      flash[:notice] = "イイねを解除しました。"
    end
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end