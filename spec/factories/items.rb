FactoryBot.define do
  factory :item do
    image { Rack::Test::UploadedFile.new('public/images/test_image.png', 'image/png') }
    product_name { Faker::Lorem.characters(number: 40) }
    product_description { Faker::Lorem.characters(number: 1000) }
    category_information_id { 2 }
    product_condition_information_id { 2 }
    shipping_cost_information_id { 2 }
    shipping_origin_information_id { 2 }
    shipping_time_id { 2 }
    pricing_information { Faker::Commerce.price(range: 300..9_999_999).to_i }
    association :user
  end
end
