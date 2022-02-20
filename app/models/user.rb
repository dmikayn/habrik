class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  validates :password, confirmation: { case_sensitive: true }
  validates_presence_of :username
  validates_presence_of :password_digest
  validates_uniqueness_of :username
end
