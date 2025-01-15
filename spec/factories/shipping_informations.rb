FactoryBot.define do
  factory :shipping_information do
    postal_code { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    shipping_origin_information_id { 1 }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number {  Faker::Number.number(digits: [10, 11].sample) }
    association :purchase_record
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
