class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_information, class_name: 'CategoryInformation'
  belongs_to :product_condition_information, class_name: 'ProductConditionInformation'
  belongs_to :shipping_cost_information, class_name: 'ShippingCostInformation'
  belongs_to :shipping_origin_information, class_name: 'ShippingOriginInformation'
  belongs_to :shipping_time, class_name: 'ShippingTime'

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :product_condition_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_cost_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_origin_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_time_id, numericality: { other_than: 1, message: "can't be blank" }
end
