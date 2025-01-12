class Address < ApplicationRecord
  belongs_to :purchase_record

  validates :postal_code, :city, :address, :phone_number, presence: true
end
