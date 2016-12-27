require 'rails_helper'

RSpec.describe "transaction management" do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user, name: "Accounts Receivables", type: "Asset") }

  before :each do
    login_as(user, scope: :user)
  end

  describe "create new transaction" do
    subject do
      visit account_path(account)
      click_link "Add transaction"
      fill_in "Amount", with: 10000
      select "Transfer", from: "Payment mode"
      fill_in "Description", with: "Cash sales"
      click_button "Submit"
    end

    it "should show success message and list new row" do
      expect { subject }.to change { account.transactions.count }.by 1
      expect(account.transactions.last.cents_amount).to eq 10000
      expect(page).to have_content "Cash sales"
      expect(page).to have_content "Transfer"
      expect(page).to have_content "Transaction successfully recorded"
    end
  end
end
