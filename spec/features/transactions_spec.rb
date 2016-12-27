require 'rails_helper'

RSpec.describe "transaction management" do
  let(:user) { create(:user) }
  before :each do
    login_as(user, scope: :user)
  end

  describe "listing transactions" do
    context "user has more than 20 transactions" do
      let!(:transactions) { create_list(:transaction, 25, user: user) }
      it "shows all 25 transactions in a reverse chronological order" do
        visit "/"
        expect(page).to have_selector(".transaction", count: 25)
        expect(first(".transaction").find(".id").text).to eq transactions.last.id.to_s
      end
    end

    context "user has no transactions" do
      it "shows the empty transactions message" do
        visit "/"
        expect(page).to have_content('No transactions recorded yet. Click "Add" to start.')
      end
    end
  end

  describe "create new transaction" do
    # See http://accounting-simplified.com/financial/double-entry/debit-&-credit.html
    let(:account1) { create(:account, name: "Accounts Receivables", type: "Asset") }
    let(:account2) { create(:account, name: "Sales Revenue", type: "Income") }
    subject do
      visit "/"
      click_link "Add new"
      select "Accounts Receivables", from: "First account"
      fill_in "Amount", with: 100.00
      select "Sales Revenue", from: "Second account"
      click_link "Submit"
    end

    it "should show success message and list new row" do
      expect { subject }.to change { [account1.records.count, account2.records.count] }.
        by { [1, 1] }
      expect(account1.records.last.amount).to eq 10000
      expect(account2.records.last.amount).to eq 10000

      expect(Transaction.last.credit).to be_a Record
      expect(Transaction.last.debit).to be_a Record
    end
  end
end
