require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create!(name: "test username", start_at: Date.yesterday, end_at: Date.today)
  end
 
  it "is invalid" do
    @user.name = "test username"
    expect(@user).to be_valid
  end

end
