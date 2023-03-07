class AddOtpToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp_code, :integer
    add_column :users, :otp_sent_at, :datetime
    add_column :users, :verified, :boolean, default: false
  end
end
