FactoryGirl.define do
  factory :application do
    sequence(:name) { |n| "Application #{n}"}
    sequence(:key) { |n| "app_#{n}"}
    sequence(:description) { |n| "description of app #{n}"}
    developer { create(:developer) }
  end
end
