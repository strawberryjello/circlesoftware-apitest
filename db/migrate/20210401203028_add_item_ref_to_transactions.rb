class AddItemRefToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :item, null: false, foreign_key: true
  end
end
