FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    access_level { 1 }
    active { true }
  end
end
