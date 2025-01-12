class PurchaseRecord < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address
end

# address.rb
class Address < ApplicationRecord
  belongs_to :purchase_record
end
