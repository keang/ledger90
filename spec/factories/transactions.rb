FactoryGirl.define do
  factory :transaction do
    cents_amount { rand(-1000...1000) }
    description { Forgery(:lorem_ipsum).sentence }

    trait :increment do
      cents_amount { rand(1...1000) }
    end

    trait :decrement do
      cents_amount { rand(-1000...0) }
    end
  end
end
