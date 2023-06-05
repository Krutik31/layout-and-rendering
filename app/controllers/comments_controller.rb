class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.includes(:comments).find(params['post_id'])
  end

  def new
    @post = Post.find(params['post_id'])
    @comment = @post.comments.new
  end

  def create
    puts 'kp'
    @comment = current_user.comments.new(post_id: params[:post_id], comment: comment_params[:comment])
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_comments_path, notice: 'Comment was successfully created.' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_comments_path, notice: 'Comment was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
