FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "admin_#{n}@email.com"}
    sequence(:password) { |n| "admin_password_#{n}"}
  end
end
