class PagesController < ApplicationController
  def home
    @posts = Post.order(:title).page params[:page]
  end
end
