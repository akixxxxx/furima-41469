class Item < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :product_name, presence: true, length: { maximum: 40 }
  validates :product_description, presence: true, length: { maximum: 1000 }
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_information, class_name: 'CategoryInformation'
  belongs_to :product_condition_information, class_name: 'ProductConditionInformation'
  belongs_to :shipping_cost_information, class_name: 'ShippingCostInformation'
  belongs_to :shipping_origin_information, class_name: 'ShippingOriginInformation'
  belongs_to :shipping_time, class_name: 'ShippingTime'

  validates :pricing_information,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'must be between ¥300 and ¥9,999,999' }

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_information_id, numericality: { other_than: 1, message: "can't be blank!" }
  validates :product_condition_information_id, numericality: { other_than: 1, message: "can't be blank!!" }
  validates :shipping_cost_information_id, numericality: { other_than: 1, message: "can't be blank!!!" }
  validates :shipping_origin_information_id, numericality: { other_than: 1, message: "can't be blank!!!!" }
  validates :shipping_time_id, numericality: { other_than: 1, message: "can't be blank!!!!!" }
end
