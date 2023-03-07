class User < ApplicationRecord
  attr_writer :login

  after_create :send_user_otp

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, authentication_keys: [:phone_number]

  def login
    @login || phone_number
  end

  def send_user_otp
    unverify!
    otp = generate_codes
    update_column(:otp_code, otp)
    VerifyMailer.with(id:).verification_email.deliver_now
    touch(:otp_sent_at)
  end

  def unverify!
    update_column(:verified, false)
  end

  def generate_codes
    loop do
      code = rand(0o00000..999_999).to_s
      break code unless code.length != 6
    end
  end
end
