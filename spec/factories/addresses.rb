FactoryBot.define do
  factory :address do
    postal_code { "MyString" }
    prefecture { "MyString" }
    city { "MyString" }
    block { "MyString" }
    building { "MyString" }
    phone_number { "MyString" }
    order { nil }
  end
end
