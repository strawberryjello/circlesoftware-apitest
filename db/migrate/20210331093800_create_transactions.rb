class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.datetime :date_and_time
      t.string :document_number
      t.string :reference_number
      t.integer :quantity
      t.decimal :total_extax_value, precision: 13, scale: 2
      t.decimal :total_tax, precision: 13, scale: 2
      t.decimal :total_discount_given, precision: 13, scale: 2

      t.timestamps
    end
  end
end
