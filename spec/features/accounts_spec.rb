require 'rails_helper'

RSpec.describe "account management" do
  let(:user) { create(:user) }

  before :each do
    login_as(user, scope: :user)
  end

  describe "list accounts" do
    let!(:accounts) { create_list(:account, 3, user: user) }
    subject do
      visit root_path
    end

    it "should show accounts details" do
      subject
      accounts.each do |acc|
        expect(page).to have_content acc.name
        expect(page).to have_content acc.type
        expect(page).to have_content acc.dollar_balance
      end
    end
  end

  describe "showing an account" do
    let(:account) { create(:account, user: user, type: "Asset") }
    context "account has many credit and debit transactions" do
      let!(:debits) { create_list(:transaction, 15, :increment, account: account) }
      let!(:credits) { create_list(:transaction, 5, :decrement, account: account) }

      it "shows all transactions in a reverse chronological order" do
        visit account_path(account)
        expect(page).to have_selector(".transaction", count: 20)
        within(".debits") do
          expect(first(".transaction").find(".id").text).to eq debits.last.id.to_s
        end
        within(".credits") do
          expect(first(".transaction").find(".id").text).to eq credits.last.id.to_s
        end
        expect(page).to have_content account.name
        expect(page).to have_content account.type
        expect(page).to have_content account.dollar_balance
      end
    end

    context "account has no transactions" do
      it "shows the empty transactions message" do
        visit account_path(account)
        expect(page).to have_content('No transactions recorded yet. Click "Add" to start.')
      end
    end
  end

  describe "create new account" do
    subject do
      visit root_path
      click_link "Create new account"
      fill_in "Name", with: "OCBC Savings"
      select "Asset", from: "Account type"
      fill_in "Starting balance (in cents)", with: "0"
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
