class User < ApplicationRecord
  has_secure_password
  #attr_accessor :password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_insensitive: false }
end
