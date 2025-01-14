FactoryBot.define do
  factory :order_form do
    postal_code { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    shipping_origin_information_id { 2 }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number {  Faker::Number.number(digits: [10, 11].sample) }
    token { 'tok_abcdefghijk00000000000000000' }
    item_id                     { 1 }
    user_id                     { 1 }
  end
end
