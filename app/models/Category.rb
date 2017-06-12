class Category < ActiveRecord::Base
  has_many :transactions
  
  validates :name, presence: true

  def get_incomes(from, to)
    self.transactions.where("amount > ? AND created_at BETWEEN ? AND ?", 0 , from, to).sum(:amount)
  end

  def get_expenses(from, to)
    self.transactions.where("amount < ? AND created_at BETWEEN ? AND ?", 0 , from, to).sum(:amount)
  end

end