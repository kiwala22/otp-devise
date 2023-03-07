class VerifyController < ApplicationController
  skip_before_action :redirect_if_unverified
  before_action :verification_access

  def new; end

  def generate
    current_user.send_user_otp
    redirect_to new_verify_url, notice: 'A PIN number has been sent to your email'
  end

  def authenticate
    if current_user.otp_sent_at.nil?
      generate and return
    end

    if Time.now > current_user.otp_sent_at&.advance(minutes: 10)
      # flash.now[:alert] = 'Your pin has expired. Please request another.'
      redirect_to new_verify_path, alert: 'Your pin has expired. Please request another.'
      # render :new and return
      # return
    elsif params[:otp_code].try(:to_i) == current_user.otp_code
      current_user.update_attribute(:verified, true)
      redirect_to root_path, notice: 'Your phone number has been verified!'
    else
      # flash.now[:alert] = 'The code you entered is invalid.'
      redirect_to new_verify_path, alert: 'The code you entered is invalid.'
    end
  end

  protected
  def verification_access
    if (!user_signed_in? || current_user.verified?)
      redirect_to root_path, notice: "Page you requested can not be found."
    end
  end
end
