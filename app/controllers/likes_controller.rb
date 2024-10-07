class LikesController < ApplicationController
  before_action :find_post

  def like
    @posts = current_user.liked_posts.page(params[:page]).per(5)
  end

  def create
    @like = @post.likes.create(user: current_user)
    render json: { post_id: @post.id, like_count: @post.likes.count, button_html: render_to_string(partial: 'likes/like_button', locals: { post: @post }) }
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    @like.destroy if @like
    render json: { post_id: @post.id, like_count: @post.likes.count, button_html: render_to_string(partial: 'likes/like_button', locals: { post: @post }) }
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end