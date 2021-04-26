class MonthlySalesReportsController < ApplicationController

  # GET /monthly_sales_reports
  def index
    @reports = MonthlySalesReport.all_grouped_by_year
    render json: @reports
  end
end
