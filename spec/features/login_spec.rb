require 'rails_helper'

describe 'Login' do
  let!(:user) { create :user }

  before do
    visit new_login_path
    expect(page).to have_text('Log In')
    fill_in 'name', with: user.name
  end

  it 'logged in user with correct data' do
    fill_in 'password', with: user.password
    click_button('login')
    expect(page).to have_text('My finance app')
  end

  it 'invalid password' do
    fill_in 'Password', with: '123'
    click_button('login')
    expect(page).to have_text('Your email address or password does not match')
  end

  it 'invalid password' do
    fill_in 'name', with: 'aaa'
    fill_in 'password', with: user.password
    click_button('login')
    expect(page).to have_text('Your email address or password does not match')
  end
end
