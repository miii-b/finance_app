require 'rails_helper'

describe UsersController, :type => :controller do

  describe "GET index" do

      it 'should respond' do
        get :index
        expect(response.status).to eq(200)
      end

      it "renders :index view" do
        get :index
        expect(response).to(render_template :index)
      end
  end

  describe "DELETE destroy countries" do

      before(:example) do
        @user = create( name: 'Test@user.com', password: '123')
      end

      it 'should respond with redirect code 302' do
        delete :destroy, id: @user.id
        expect(response.status).to eq(302)
      end

      it "destroy method is called" do
        delete :destroy, id: @user.id
        expect(Country.count).to eq 0
      end

      it "renders countries index view" do
        delete :destroy, id: @user.id
        expect(response).to redirect_to(countries_path)
      end

    end

end
