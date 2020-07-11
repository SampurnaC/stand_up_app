require "rails_helper"

RSpec.describe UsersController, type: :controller do

  before do
    @user = User.create!(name: "test username", start_at: Date.yesterday, end_at: Date.today)
  end

  describe "GET #new" do
    it "should get new" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #index" do
    it "should get index" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET/index generate CSV" do
    before :each do
      get :index, format: :csv
    end
  
    it "generate CSV" do
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.headers["Content-Disposition"]).to eq "attachment; filename=\"standup-listings.csv\"; filename*=UTF-8''standup-listings.csv"
      csv_data = CSV.parse(response.body)
      csv_header = csv_data.shift
      expect(csv_header).to match_array ["ID", "NAME", "Work Log"]
    end
  end
  
  describe "POST #create" do
    it "should create a User" do
      expect { post :create, params: { user: { name: "test", start_at: Date.yesterday, end_at: Date.today } } }.to change { User.count }
      expect(response).to redirect_to root_path
    end

    it "should not create a user when invalid data are provided" do
      expect { post :create, params: { user: { user_id: @user.id, name: nil, start_at: Date.yesterday, end_at: Date.today } } }.not_to change { User.count }
      expect(flash[:error]).to be_present
      expect(response).to redirect_to root_path
    end
  end
  
  describe "#destroy" do
    it "should delete work log" do
      @user = User.create!(name: "test username", start_at: 1.hour.ago, end_at: Date.today)
      expect { delete :destroy, params: { id: @user.id } }.to change(User, :count).by(-1)
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to root_path
    end
  end

  it "GET#edit" do
    get :edit, params: { id: @user.id }, format: "js"
    expect(response).to be_successful
  end

  describe "PATCH #update" do
    it "should update the User" do
      patch :update, params: { id: @user.id, user: { name: "Updated Name" } }
      @user.reload
      expect(@user.name).to eq("Updated Name")
    end
  end

end
