class User < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password
end