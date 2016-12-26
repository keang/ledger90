require 'rails_helper'

RSpec.describe "transaction management" do
  let(:user) { create(:user) }
  before :each do
    login_as(user, scope: :user)
  end

  it "shows title" do
    visit "/"
    expect(page).to have_content "Transactions"
  end
end
