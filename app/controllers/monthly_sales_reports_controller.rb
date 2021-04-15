class MonthlySalesReportsController < ApplicationController

  # GET /annual_sales_reports
  def index
    @reports = MonthlySalesReport.all
    render json: @reports
  end
end
