require "rails_helper"

feature "Admin::Users" do
  before do
    @user = User.create!(name: "test username", start_at: 3.days.ago, end_at: 2.days.ago, created_at: 2.days.ago)
  end

  describe "GET #index" do
    before do
      visit users_path
    end
    
    it "should display all standups" do
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Start At")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: @user.start_at)
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "End At")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: @user.end_at)
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Work Log of Today (HH:MM:SS)")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: "cannot be calculated of previous dates")
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Created At")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: @user.end_at)
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Status")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: "Absent")
    end

    it "should have reset button" do
      click_link('Reset')
      expect(current_path).to eq '/users'
    end

    it "should have export to csv link" do
      click_link('Export Stand Ups')
      expect(current_path).to eq '/users.csv'
    end

  end

  describe "GET #new" do
    before do
      visit root_path
    end

    it "should have the name field" do
      expect(page).to have_xpath("//div[@class='col-md-3 form-group']/label", text: "Name")
      expect(page).to have_xpath("//input[@id='user_name' and @type='text']", text: "")
    end

    it "should have the start_at date" do
      expect(page).to have_xpath("//label", text: "Start at")
      expect(page).to have_xpath("//select[@id='user_start_at_1i']")
      expect(page).to have_xpath("//select[@id='user_start_at_2i']")
      expect(page).to have_xpath("//select[@id='user_start_at_3i']")
      expect(page).to have_xpath("//select[@id='user_start_at_4i']")
      expect(page).to have_xpath("//select[@id='user_start_at_5i']")
    end

    it "should have the end_at date" do
      expect(page).to have_xpath("//label", text: "End at")
      expect(page).to have_xpath("//select[@id='user_start_at_1i']")
      expect(page).to have_xpath("//select[@id='user_start_at_2i']")
      expect(page).to have_xpath("//select[@id='user_start_at_3i']")
      expect(page).to have_xpath("//select[@id='user_start_at_4i']")
      expect(page).to have_xpath("//select[@id='user_start_at_5i']")
    end

    it "should display all standups" do
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Start At")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: @user.start_at)
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "End At")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: @user.end_at)
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Work Log of Today (HH:MM:SS)")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: "cannot be calculated of previous dates")
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Created At")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: @user.end_at)
      expect(page).to have_xpath("//table[@class='table log']/thead/tr/th", text: "Status")
      expect(page).to have_xpath("//table[@class='table log']/tbody/tr/td", text: "Present")
    end

    # it "should have edit and delete buttons" do
    #   binding.pry

    #   @user.update(created_at:  DateTime.now.strftime("%m/%d/%Y"))
    #   @user.update(created_at: @user.created_at.strftime('%m/%d/%Y'))
    #   expect(page).to have_content "Edit"
    #   expect(page).to have_content "Delete"
    # end

  end

  describe "POST #create" do
    before do
      visit new_user_path
    end

    it "should create a stand up successfully" do
      fill_in :user_name, with: "Name"
      select "2020", from: "user_start_at_1i"
      select "July", from: "user_start_at_2i"
      select "9", from: "user_start_at_3i"
      select "15", from: "user_start_at_4i"
      select "54", from: "user_start_at_5i"
      click_button "Create"
      @user = User.last
      expect(@user.name).to eq "Name"
    end

    it "should have a link to list users" do
      find(:xpath, "//a[@href='/users']").click
      expect(current_path).to eq '/users'
    end

  end

end
