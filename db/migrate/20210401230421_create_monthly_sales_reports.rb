class CreateMonthlySalesReports < ActiveRecord::Migration[6.1]
  def change
    create_table :monthly_sales_reports do |t|
      t.datetime :year_and_month
      t.decimal :total_ex_sales, precision: 13, scale: 2
      t.decimal :gross_profit, precision: 13, scale: 2

      t.timestamps
    end
  end
end
