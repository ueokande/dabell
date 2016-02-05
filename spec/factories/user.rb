FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "alice_#{n}" }
    sequence(:full_name) { |n| "Alice Dabell #{n}" }
    sequence(:email) { |n| "alice_#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
