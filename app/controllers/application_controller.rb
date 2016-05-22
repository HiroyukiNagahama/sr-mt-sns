class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def is_manager
    return true if current_user.manager
    forbidden_page
  end

  def forbidden_page
    render :text => "403 request ip:(#{request.remote_ip}) forbidden"#, status: :forbidden
  end

  protected
  #config/initializer/devise.rbの変更だけではなくappも許可する
  # def configure_permitted_parameters
  #   # sign_inのときに、usernameも許可する
  #   devise_parameter_sanitizer.for(:sign_in) << :name
  #   # sign_upのときに、usernameも許可する
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  #   #  account_updateのときに、usernameも許可する
  #   devise_parameter_sanitizer.for(:account_update) << :name
  # end
end
