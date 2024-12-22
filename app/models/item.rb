class Item < ApplicationRecord
  belongs_to :users
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_information
  belongs_to :product_condition_information
  belongs_to :shipping_cost_information
  belongs_to :shipping_origin_information
  belongs_to :shipping_time

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :product_condition_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_cost_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_origin_information_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_time_id, numericality: { other_than: 1, message: "can't be blank" }
end
