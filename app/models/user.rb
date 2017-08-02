class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    user_params = auth.slice(:provider, :uid)
      user_params[:email] = auth.info.email
      user_params[:pseudo] = auth.info.nickname
      user_params = user_params.to_h

      user = User.where(provider: auth.provider, uid: auth.uid).first
      user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
      if user
        user.update(user_params)
      else
        user = User.new(user_params)
        user.password = Devise.friendly_token[0,20]  # Fake password for validation
        user.save
      end
    return user
  end
end
