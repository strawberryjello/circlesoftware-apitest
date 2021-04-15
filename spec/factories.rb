#!/usr/bin/env ruby

FactoryBot.define do
  factory :random_monthly_sales_report, class: MonthlySalesReport do
    year_and_month { Faker::Date.between(from: '2004-01-01', to: '2018-12-01') }
    total_ex_sales { Faker::Number.decimal(l_digits: 4) }
    gross_profit { Faker::Number.decimal(l_digits: 4) }
  end
end
