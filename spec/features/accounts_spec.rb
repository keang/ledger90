require 'rails_helper'

RSpec.describe "account management" do
  let(:user) { create(:user) }

  before :each do
    login_as(user, scope: :user)
  end

  describe "create new account" do
    subject do
      visit root_path
      click_link "Create new account"
      fill_in "Name", with: "OCBC Savings"
      select "Asset", from: "Account type"
      fill_in "Starting balance", with: "0"
      click_button "Submit"
    end

    it "should create a new account" do
      expect { subject }.to change { user.accounts.count }.by 1
      expect(page).to have_content "OCBC Savings"
      expect(page).to have_content "Account successfully created"
      expect(page).to have_content "No transactions recorded yet"
    end
  end
end
