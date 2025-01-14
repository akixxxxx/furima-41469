class OrderForm
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :shipping_origin_information_id, :city, :address, :building_name, :phone_number,
                :token, :purchase_record_id
  
  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :item_id
    validates :user_id
    VALID_POSTAL_CODE_REGEX = /\A\d{3}-\d{4}\z/
    VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
    validates :postal_code,  format: { with: VALID_POSTAL_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }

    validates :city
    validates :address
    validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }
    validates :token
  end
    validates :shipping_origin_information_id, numericality: { other_than: 1 , message: "can't be blank"}
  def save

    if valid?
      ActiveRecord::Base.transaction do
        # 購入情報の保存
        purchase_record = PurchaseRecord.create!(item_id: item_id, user_id: user_id)
        Rails.logger.debug "Creating ShippingInformation with: postal_code=#{postal_code}, shipping_origin_information_id=#{shipping_origin_information_id}, city=#{city}, address=#{address}, building_name=#{building_name}, phone_number=#{phone_number}"
        # 発送先情報の保存
        ShippingInformation.create!(
          postal_code: postal_code,
          shipping_origin_information_id: shipping_origin_information_id,
          city: city,
          address: address,
          building_name: building_name,
          phone_number: phone_number,
          purchase_record_id: purchase_record.id
        )
      end
      true
    else
      false
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
