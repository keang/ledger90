FactoryGirl.define do
  factory :account do
    user { create_user }
    cents_balance { rand(10000) }
    type { %w(Asset Expense Income Equity Liability).sample }
    name { Forgery(:lorem_ipsum).word }
  end
end
