class PurchaseRecord < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :shipping_information
end
