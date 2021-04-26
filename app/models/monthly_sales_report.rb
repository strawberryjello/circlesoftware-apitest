class MonthlySalesReport < ApplicationRecord

  def self.get_unique_years
    MonthlySalesReport.select("to_char(year_and_month, 'YYYY')").distinct
  end

  def self.all_grouped_by_year
    query = %{
    select
        to_char(year_and_month, 'YYYY') as year,
        to_char(year_and_month, 'Mon') as month,
        total_ex_sales,
        gross_profit
    from monthly_sales_reports
    group by year_and_month, total_ex_sales, gross_profit
    order by year_and_month desc
    }
    query_result = ActiveRecord::Base.connection.execute(query)

    records = {}
    query_result.each do |r|
      records[r["year"]] = [] unless records[r["year"]]

      records[r["year"]] << r
    end

    records.to_a
  end
 
end
