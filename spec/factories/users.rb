FactoryGirl.define do
  factory :user do
    email                 "test@example.com"
    password              "test_password"
    password_confirmation "test_password"
  end
end
