require 'rails_helper'

describe Account, type: :model do
  subject { create :account }

  it { should validate_presence_of(:name) }

  it 'factory should produce valid account' do
    account = build :account
    expect(account).to be_valid
  end
end
