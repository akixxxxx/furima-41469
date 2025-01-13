class ShippingInformation < ApplicationRecord
  belongs_to :purchase_record

  attr_accessor :item, :user, :postal_code, :shipping_origin_information_id, :city, :address, :building_name, :phone_number,
                :token

  VALID_POSTAL_CODE_REGEX = /\A\d{3}-\d{4}\z/
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }
  validates :shipping_origin_information_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
end
