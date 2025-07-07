FactoryBot.define do
  factory :user do
    name { "MyString" }
    sequence(:email) { |n| "mystring#{n}@email.com" }
    password { "123123123" }
    password_confirmation { '123123123' }
    access_level { 1 }
    active { true }
  end
end
