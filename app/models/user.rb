class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :addresses
  has_many :orders

  def self.from_omniauth(auth)
    user = User.where(:email => auth.info.email).first

    unless user
      password = Devise.friendly_token[0,20]
      user = User.create(email: auth.info.email, name: auth.info.first_name, surname: auth.info.second_name,
                         password: password, password_confirmation: password,
                         provider: auth.provider, uid: auth.uid)
    end
    user
  end

end
