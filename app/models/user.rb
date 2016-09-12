class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password, :password_confirmation
  validates :email, uniqueness: true
end
