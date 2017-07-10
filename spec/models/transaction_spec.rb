require 'rails_helper'

describe Transaction, type: :model do

  it { should validate_presence_of(:category_id) }
  it { should validate_presence_of(:account_id) }
  it { should validate_presence_of(:amount) }

end
