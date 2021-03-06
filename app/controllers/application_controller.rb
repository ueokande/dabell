class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action:configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :full_name << :email << :avatar
  end
end
