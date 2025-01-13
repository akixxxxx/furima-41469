class OrderForm
  include ActiveModel::Model
  attr_accessor :item, :user, :postal_code, :shipping_origin_information_id, :city, :address, :building_name, :phone_number,
                :token

  # ここにバリデーションの処理を書く
  validates :item, presence: true
  validates :user, presence: true
  VALID_POSTAL_CODE_REGEX = /\A\d{3}-\d{4}\z/
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }
  validates :shipping_origin_information_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :token, presence: true

  def save
    if valid?
      ActiveRecord::Base.transaction do
        # 購入情報の保存
        purchase_record = PurchaseRecord.create!(item: item, user: user)
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
