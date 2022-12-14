class ApplicationController < ActionController::Base
   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
   before_action :configure_permitted_parameters, if: :devise_controller?

   protected

   def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      # devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :username, :email, :password, :password_confirmation, :remember_me, :current_password)}

      # devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
      # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :current_password)}
   end
   
   def authenticate_admin!
      authenticate_user!
      redirect_to :somewhere, status: :forbidden unless current_user.admin?
   end

   private
   def record_not_found
      redirect_to root_path
      flash[:notice] = "Record not found!"
   end
end
