class LikesController < ApplicationController
  before_action :find_post

  def create
    unless already_liked?
      @like = @post.likes.create(user: current_user)
      render json: { post_id: @post.id, like_count: @post.likes.count, button_html: render_to_string(partial: 'likes/like_button', locals: { post: @post }) }
    else
      render json: { error: 'You have already liked this post' }, status: :unprocessable_entity
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    if @like
      @like.destroy
      render json: { post_id: @post.id, like_count: @post.likes.count, button_html: render_to_string(partial: 'likes/like_button', locals: { post: @post }) }
    else
      render json: { error: 'Like not found' }, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.exists?(user_id: current_user.id, post_id: @post.id)
  end
end
