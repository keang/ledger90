require 'rails_helper'

RSpec.describe "transaction management" do
  let(:user) { create(:user) }
  # See http://accounting-simplified.com/financial/double-entry/debit-&-credit.html
  let(:account) { create(:account, user: user, name: "Accounts Receivables", type: "Asset") }

  before :each do
    login_as(user, scope: :user)
  end

  describe "listing transactions" do
    context "user has more than 20 transactions" do
      let!(:transactions) { create_list(:transaction, 25, account: account) }
      it "shows all 25 transactions in a reverse chronological order" do
        visit account_path(account)
        expect(page).to have_selector(".transaction", count: 25)
        expect(first(".transaction").find(".id").text).to eq transactions.last.id.to_s
      end
    end

    context "user has no transactions" do
      it "shows the empty transactions message" do
        visit account_path(account)
        expect(page).to have_content('No transactions recorded yet. Click "Add" to start.')
      end
    end
  end

  describe "create new transaction" do
    subject do
      visit account_path(account)
      click_link "Add new"
      # select "Accounts Receivables", from: "Account"
      fill_in "Amount", with: 10000
      fill_in "Description", with: "Cash sales"
      click_button "Submit"
    end

    it "should show success message and list new row" do
      expect { subject }.to change { account.transactions.count }.by 1
      expect(account.transactions.last.cents_amount).to eq 10000
      expect(page).to have_content "Cash sales"
      expect(page).to have_content "success"
    end
  end
end
