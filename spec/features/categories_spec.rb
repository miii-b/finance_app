require "rails_helper"

describe "Categories" do

  let!(:user){create :user}
  let(:category_1){create :category, name: 'cat1'}
  let(:account){create :account}

  let(:transaction_1){create :transaction, user_id: user.id, category_id: category_1.id, account: account, amount: 100.00}
  let(:transaction_2){create :transaction, user_id: user.id, category_id: category_1.id, account: account, amount: -10.00 }
  let(:transaction_3){create :transaction, user_id: user.id, category_id: category_1.id, account: account, amount: 11.00, created_at: Time.now - 2.week }
  
  before do 
    visit new_login_path
    fill_in('name',{with: user.name})
    fill_in 'password', with: user.password
    click_button('login')
    visit categories_path
  end

  it 'from = to, shows all day' do  
    category_1.reload 
    transaction_1.reload
    transaction_2.reload
    page.find_field('from').set(Date.today)
    page.find_field('to').set(Date.today)
    
    click_button('select')

    expect(page).to have_text('100.0')
    expect(page).to have_text('-10.0')
    expect(page).not_to have_text('11.0')
  end

  it "from > to, raises error message" do  
    page.find_field('from').set(Date.today + 1.week)
    page.find_field('to').set(Date.today)
    
    click_button('select')
    
    expect(page).to have_text('Wrong range entered. Using default values')
  end

  it "correct date range, no results" do  
    page.find_field('from').set(Date.today - 1.week)
    page.find_field('to').set(Date.today - 1.day )
    
    click_button('select')
    
    expect(page).not_to have_text('-10.0')
    expect(page).not_to have_text('100.0')
  end

  it "correct date range with results" do  
    page.find_field('from').set(Date.today - 2.week)
    page.find_field('to').set(Date.today - 1.day )
    
    click_button('select')

    expect(page).not_to have_text('11.0')

  end
end
