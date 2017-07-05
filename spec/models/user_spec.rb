require 'rails_helper'

describe User, type: :model do
  subject { create :user }

  it { should validate_presence_of(:name) }
 # it { should validate_presence_of(:password) }

  it 'factory should produce valid user' do
    user = build :user
    expect(user).to be_valid
  end

end
