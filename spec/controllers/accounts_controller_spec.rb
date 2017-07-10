require 'rails_helper'

describe AccountsController, type: :controller do
  let(:user) {create :user}

  before do 
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "create new account" do
    post :create, "account": {"critical_value": "10.00", "user_id": user.id, "notification": true, "name": "test account"}
    
    expect(response).to redirect_to accounts_path

    expect(Account.first.name).to eq 'test account'
  end

  it "update account" do
    account = create :account, critical_value: 10.00, user_id: user.id, notification: true, name: 'test account'
    post :update, "account": { "name": "new account name" }, id: account.id
    
    expect(response).to redirect_to accounts_path

    expect(Account.first.name).to eq 'new account name'
  end

end
