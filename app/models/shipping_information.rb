class ShippingInformation < ApplicationRecord
  belongs_to :purchase_record
  belongs_to :user
end
