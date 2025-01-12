class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :block
      t.string :building
      t.string :phone_number
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
