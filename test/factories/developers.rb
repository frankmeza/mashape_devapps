FactoryGirl.define do
  factory :developer do
    sequence(:username) { |n| "developer #{n}"}
    sequence(:email) { |n| "dev_#{n}@email.com"}
    sequence(:password) { |n| "dev_password_#{n}"}
  end
end
