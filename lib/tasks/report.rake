require "benchmark"

namespace :report do

  desc "Create monthly reports in DB"
  task :create => :environment do
    elapsed_time = Benchmark.measure do
      puts "Querying transactions table"

      query = %{
        select
        date_trunc('month', date_and_time) as year_and_month,
        sum(total_extax_value) as total_ex_sales,
        sum(profit) as gross_profit
        from transactions
        group by year_and_month
        order by year_and_month desc
      }
      query_result = ActiveRecord::Base.connection.execute(query)

      puts "Found #{query_result.count} records"

      query_result.each do |r|
        MonthlySalesReport.create(
          year_and_month: r["year_and_month"],
          total_ex_sales: r["total_ex_sales"],
          gross_profit: r["gross_profit"]
        )
      end

      puts "Created #{MonthlySalesReport.count} monthly sales reports in DB"
    end

    puts "Time elapsed in seconds: #{elapsed_time.real}"
  end
end
