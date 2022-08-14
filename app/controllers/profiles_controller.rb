class ProfilesController < ApplicationController
    before_action :set_user
    before_action :authenticate_user!
    
    def show
        @profile_posts = @profile.posts.find_by_id(params[:post_id])
    end

    private

    def set_user
        @profile = User.find(params[:id])        
    end
    
end