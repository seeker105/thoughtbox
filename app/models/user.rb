class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password, :password_confirmation
  validates :email, uniqueness: true
  has_many :links


  # def permitted(user_params)
  #   user_params[:password] == user_params[:password_confirmation] && self.authenticate(user_params[:password])
  # end
end
