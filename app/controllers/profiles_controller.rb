class ProfilesController < ApplicationController
    before_action :set_user, except: :destroy_post
    before_action :authenticate_user!
    before_action :correct_admin, only: [:userlist, :allpost] 

    def update
        if @profile.admin == true
            @profile.update_attribute(:admin, false)
        elsif @profile.admin == false
            @profile.update_attribute(:admin, true)
        end
        redirect_to request.referrer
    end

    def show
        @q = @profile.posts.ransack(params[:q])
        @posts = @q.result.order(:title).page params[:page]
        @profile_lists = User.all
    end

    def destroy
        @profile.destroy
        redirect_to request.referrer
    end

    def destroy_post
        @post = Post.find(params[:id])
        if @post.destroy
            flash[:notice] = "This post was successfully deleted."
        else
            flash[:notice] = "Something wrong."
        end
        redirect_to request.referrer
    end
    

    def userlist
        @profile_lists = User.all
    end

    def allpost
        @q = Post.with_rich_text_richbody_and_embeds.ransack(params[:q])
        @posts = @q.result.order(:title).page params[:page]
    end

    private
    
    def correct_admin
        redirect_to profile_path(@profile), notice: "You are not an admin or not authorize to see other page." if @profile.admin == false
    end

    def set_user
        @profile = User.find(params[:id])      
    end
end