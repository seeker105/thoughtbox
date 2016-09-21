class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates :password, confirmation: true
  validates :email, uniqueness: true
  has_many :links

end
