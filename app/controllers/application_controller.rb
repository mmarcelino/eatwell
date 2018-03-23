class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def location
    if params[:location].blank?
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("50.78.167.161").first
      else
        @location ||= request.location
      end
    else
      params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
      @location ||= Geocoder.search(params[:location]).first
      @location
    end
  end

  protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u|
      u.permit(:username, :email, :password, :first_name, :last_name,
      :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar)
    }


    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email,
      :password, :first_name, :last_name, :password_confirmation, :current_password,
      :avatar, :avatar_cache, :remove_avatar) }
  end
end
