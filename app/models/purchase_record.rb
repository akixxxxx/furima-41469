class PurchaseRecord < ApplicationRecord
  belongs_to :items
  belongs_to :users
  has_one :shipping_information
end
