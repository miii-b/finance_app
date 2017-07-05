require 'rails_helper'

describe LoginsController, type: :controller do

  it "renders :index view" do
    get :new
    expect(response).to(render_template :new)
  end


end
