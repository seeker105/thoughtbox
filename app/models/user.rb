class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password, :password_confirmation
  validates :email, uniqueness: true
  has_many :links 

  def self.from_params(user_params)
    # byebug
    where(email: user_params[:email]).first_or_create do |new_user|
      new_user.email                  = user_params[:email]
      new_user.password               = user_params[:password]
      new_user.password_confirmation  = user_params[:password_confirmation]
    end
  end
end
