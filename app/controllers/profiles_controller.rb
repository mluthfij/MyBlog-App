class ProfilesController < ApplicationController
    before_action :set_user
    before_action :authenticate_user!
    
    def show
        @profile_posts = @profile.posts.find_by_id(params[:post_id])
        # @posts = @profile.posts.order(:title).page params[:page]
        @q = @profile.posts.ransack(params[:q])
        @posts = @q.result.order(:title).page params[:page]
    end

    private

    def set_user
        @profile = User.find(params[:id])      
    end

end