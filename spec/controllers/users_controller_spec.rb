require 'rails_helper'

describe UsersController, type: :controller do
  describe 'delete user' do
    before(:example) do
      @user = create :user
      allow(controller).to receive(:current_user).and_return(@user)
    end

    it 'should respond with redirect code 302' do
      delete :destroy, id: @user.id
      expect(response.status).to eq(302)
    end

    it 'renders root' do
      expect(User.count).to be 1
      delete :destroy, id: @user.id
      expect(User.count).to be 0
      expect(response).to redirect_to users_path
    end
  end
end
