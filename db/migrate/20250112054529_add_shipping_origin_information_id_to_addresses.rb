class AddShippingOriginInformationIdToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :shipping_origin_information_id, :integer
  end
end
