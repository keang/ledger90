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
end
