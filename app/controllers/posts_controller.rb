class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @posts = @posts.where("title LIKE ?", "%#{params[:query]}%") if params[:query].present?
    @posts = @posts.where(tag: params[:tag]) if params[:tag].present?
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿に成功しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: '投稿を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end
  
  def search
   @posts = Post.all

    if params[:tag].present?
      @posts = @posts.where(tag: Post.tags[params[:tag]])
    end

    if params[:query].present?
      @posts = @posts.where("title LIKE ?", "%#{params[:query]}%")
    end

    render :search
  end
  
  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :link, :tag)
    end

end
