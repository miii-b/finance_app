require 'rails_helper'

describe TransactionsController, type: :controller do

  it "create redirect to accounts" do
    user = create :user
    cat = create :category
    account  = create :account, user_id: user.id, critical_value: 10.00

    allow(controller).to receive(:current_user).and_return(user)
    
    post :create, "transaction": {"purpose": "testing", "amount": "10", "account_id": account.id, "user_id": user.id, "category_id": cat.id}
    
    expect(response).to redirect_to accounts_path

    expect(Transaction.first.purpose).to eq 'testing'
  end

end
