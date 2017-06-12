class User < ActiveRecord::Base
  has_many :transactions
  has_many :accounts
  has_many :sessions

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password
end