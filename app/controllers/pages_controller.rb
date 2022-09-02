class PagesController < ApplicationController
  def home
    @posts = Post.with_rich_text_richbody_and_embeds.order(:title).page params[:page]
  end
end
