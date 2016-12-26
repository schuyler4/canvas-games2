class User < ApplicationRecord
  has_secure_password
  has_many :games
  has_many :comments

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
