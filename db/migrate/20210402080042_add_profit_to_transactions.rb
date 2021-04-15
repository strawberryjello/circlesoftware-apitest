class AddProfitToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :profit, :decimal, precision: 13, scale: 2
  end
end
