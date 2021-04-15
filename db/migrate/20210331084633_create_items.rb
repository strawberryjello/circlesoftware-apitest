class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :apn
      t.string :description
      t.decimal :rrp, precision: 7, scale: 2
      t.decimal :last_buy_price, precision: 7, scale: 2
      t.string :product_category
      t.integer :actual_stock_on_hand

      t.timestamps
    end
  end
end
