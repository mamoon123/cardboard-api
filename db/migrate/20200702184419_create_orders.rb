class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.integer :price
      t.integer :discount
      t.integer :shipping_fee
      t.integer :total_price
      t.string :card_type

      t.timestamps
    end
  end
end
