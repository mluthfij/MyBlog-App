class CommentsController < ApplicationController
  before_action :set_params, only: [:create, :destroy]
  before_action :authenticate_user!

  def create
    # @comment = @post.comments.create(params_comment)
    @comment = current_user.comments.new(params_comment)
    if !@comment.save
        flash[:notice] = @comment.errors.full_messages.to_sentence
    end
    flash[:notice] = "Comment has been sent successfully."
    redirect_to post_path(@post)
  end

  def destroy
    # @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_params
    @post = Post.find(params[:post_id])
  end

  def params_comment
    # params[:comment]
    params.require(:comment)
    .permit(:content, :parent_id, :replyto)
    .merge(post_id: params[:post_id])
  end
end
