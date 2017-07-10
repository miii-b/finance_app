class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  belongs_to :user

  validates :category_id, presence: true
  validates :account_id, presence: true
  validates :amount, presence: true
end
