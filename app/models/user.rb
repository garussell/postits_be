class User < ApplicationRecord
  has_many :postits
  validates_presence_of :username

  has_secure_password
end
