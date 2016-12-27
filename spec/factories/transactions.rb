FactoryGirl.define do
  factory :transaction do
    cents_amount { rand(-1000...1000) }
    description { Forgery(:lorem_ipsum).sentence }
  end
end
