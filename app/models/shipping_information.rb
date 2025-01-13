class ShippingInformation < ApplicationRecord
  belongs_to :purchase_record
  attr_accessor :item, :user, :postal_code, :shipping_origin_information_id, :city, :address, :building_name, :phone_number,
                :token
end
