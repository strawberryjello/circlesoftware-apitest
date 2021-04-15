require "benchmark"
require "csv"

namespace :csv do

  desc "Load and parse csv files located in the data directory"
  task :load => :environment do
    Dir.chdir("data")
    puts "Loading files in #{Dir.pwd}"

    files = Rake::FileList["**/*.csv"]
    puts files

    elapsed_time = Benchmark.measure do
      files.each do |f|
        csv = CSV.read(f, headers: true)
        csv.each do |row|
          last_buy_price = BigDecimal(row["Last Buy Price"])
          txn_quantity = row["Trans Quantity"].to_i
          total_extax_value = BigDecimal(row["Trans Total extax value"])
          total_tax = BigDecimal(row["Trans Total tax"])
          profit = (total_extax_value + total_tax) - (last_buy_price * txn_quantity)

          item = Item.create(
            apn: row["APN code"],
            rrp: BigDecimal(row["R.R.P."]),
            last_buy_price: last_buy_price,
            description: row["Item description"],
            product_category: row["Product Category"],
            actual_stock_on_hand: row["Actual Stock On Hand"].to_i
          )

          if row["Author"]
            Author.create(name: row["Author"], item_id: item.id)
          end

          txn_date_time = row["Trans Date"] + " " + row["Trans Time"]
          Transaction.create(
            date_and_time: txn_date_time,
            document_number: row["Trans Document Number"],
            reference_number: row["Trans Reference Number"],
            quantity: txn_quantity,
            total_extax_value: total_extax_value,
            total_tax: total_tax,
            total_discount_given: BigDecimal(row["Trans Total discount given"]),
            item_id: item.id,
            profit: profit
          )
        end
      end
    end

    puts "Time elapsed in seconds: #{elapsed_time.real}"
  end
end
