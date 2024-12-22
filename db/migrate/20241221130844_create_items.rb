class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :product_name,                       null:false
      t.text :product_description,                  null:false
      t.integer :category_information_id,           null:false
      t.integer :product_condition_information_id,  null:false
      t.integer :shipping_cost_information_id,      null:false
      t.integer :shipping_origin_information_id,    null:false
      t.integer :shipping_time_id,                  null:false
      t.integer :pricing_information    ,           null:false
      t.timestamps
    end
  end
end
