class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_if_unverified

  protected

  def redirect_if_unverified
    if user_signed_in? && !current_user.verified?
      redirect_to new_verify_url, notice: "Please verify your phone number"
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[
      phone_number
      email
      password
      password_confirmation
      remember_me
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit(:sign_in, keys: [:phone_number])
  end

end
