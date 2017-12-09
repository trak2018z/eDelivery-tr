class User < ApplicationRecord
  attr_accessor :current_password

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  validates :password, presence: { on: :create }, length: { minimum: 6 },
            confirmation: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }


  has_many :addresses
  has_many :orders
  has_many :roles
  belongs_to :profile

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).or(User.where(google_oauth2_uid: auth.uid)).or(User.where(facebook_uid: auth.uid)).first

    unless user
      password = Devise.friendly_token[0,20]
      profile = Profile.create(name: auth.info.first_name, surname: auth.info.last_name, full_name: auth.info.name, phone: auth.info.phone)
      prov = (auth.provider+'_uid').to_s
      user = User.create(email: auth.info.email, password: password, password_confirmation: password, prov => auth.uid)
      user.profile = profile
      user.save!
    end
    user
  end


end
