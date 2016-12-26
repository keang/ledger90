FactoryGirl.define do
  factory :transaction do
    type ["Debit", "Credit"].sample
    cents_amount { rand(10000) }
    target { "%04d" % rand(9999) }
    source { "%04d" % rand(9999) }
    description { Forgery(:lorem_ipsum).sentence }
  end

  factory :debit do
    cents_amount { rand(10000) }
    target { "%04d" % rand(9999) }
    source { "%04d" % rand(9999) }
    description { Forgery(:lorem_ipsum).sentence }
  end

  factory :credit do
    cents_amount { rand(10000) }
    target { "%04d" % rand(9999) }
    source { "%04d" % rand(9999) }
    description { Forgery(:lorem_ipsum).sentence }
  end
end
