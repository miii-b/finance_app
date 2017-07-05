require 'rails_helper'

describe Category, type: :model do 

  let(:category){create :category}
  let(:user){create :user}  
  let(:account){create :account}
  let(:transaction_1){create :transaction, user_id: user.id, category_id: category.id, account: account, amount: 10.00}
  let(:transaction_2){create :transaction, user_id: user.id, category_id: category.id, account: account, amount: -10.00}  

  before do 
    @from = Time.now - 1.week
    @to = Time.now + 1.day
  end

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it 'factory should produce valid category' do
    cat = build :category
    expect(cat).to be_valid
  end

  it '#get_incomes' do 
    expect(category.get_incomes(@from,@to)).to eq(10.00)

  end
  it '#get_expenses' do 
    expect(category.get_expenses(@from,@to)).to eq(-10.00)
  end
end

