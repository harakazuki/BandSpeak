class LikesController < ApplicationController
  before_action :find_post

  def like
    @posts = current_user.liked_posts.page(params[:page]).per(5)
  end

  def create
  like = @post.likes.new(user: current_user)

  if like.save
    respond_to do |format|
      format.html { redirect_to @post, notice: 'いいねしました。' }
      format.js
    end
  else
    respond_to do |format|
      format.html { redirect_to @post, alert: 'いいねの追加に失敗しました。' }
      format.js { render js: "alert('いいねの追加に失敗しました。');" }
    end
  end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end