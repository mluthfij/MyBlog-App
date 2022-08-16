class CommentsController < ApplicationController
  before_action :set_params, only: [:create, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy] 

  def create
    # @comment = @post.comments.create(params_comment)
    @comment = current_user.comments.new(params_comment)
    # if !@comment.save
    #     flash[:notice] = @comment.errors.full_messages.to_sentence
    # end
    if @comment.save
      flash[:notice] = "Comment has been sent successfully."
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end
      redirect_to post_path(@post)
  end

  def destroy
    # @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment was successfully destroyed."
    redirect_to post_path(@post)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to post_path(@post), notice: "Not authorized to destroy this comment." if @comment.nil?
  end

  private

  def set_params
    @post = Post.find(params[:post_id])
  end

  def params_comment
    params.require(:comment)
    .permit(:content, :parent_id, :replyto)
    .merge(post_id: params[:post_id])
  end
end
