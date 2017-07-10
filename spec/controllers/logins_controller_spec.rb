require 'rails_helper'

describe LoginsController, type: :controller do

  it "renders :index view" do
    user = create :user
    allow(controller).to receive(:current_user).and_return(user)
    post :create
    expect(response).to(render_template :new)
  end

end
