class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_post, only: %i[update destroy edit]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      format.turbo_stream
    end
  end

  def like
    current_user.likes.find_or_create_by(post_id: params[:id])
    redirect_to posts_path
  end

  def unlike
    like = current_user.likes.find_by(post_id: params[:id])
    like.destroy
    redirect_to posts_path
  end

  private

  def fetch_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:post)
  end
end
