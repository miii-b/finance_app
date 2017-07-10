require 'rails_helper'

describe CategoriesController, type: :controller do 
  let(:user) {create :user}

  before do 
    allow(controller).to receive(:current_user).and_return(user)
  end

  it 'creates new category' do 
    post :create, "category": {"name": "test category"}
    
    expect(response).to redirect_to categories_path

    expect(Category.first.name).to eq 'test category'

  end

  it 'updates category' do 
    cat = create :category

    post :update, id: cat.id, "category": {"name": "new category name"}
    
    expect(Category.first.name).to eq 'new category name'
  end


  it 'renders index' do 
    create :category, name: 'cat1'
    
    get :index
    
    expect(response).to(render_template :index)
    expect(Category.count).to be 1
  end
end