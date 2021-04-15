require "rails_helper"

describe "get all monthly sales reports route", :type => :request do
  let!(:reports) { FactoryBot.create_list(:random_monthly_sales_report, 20) }

  before { get "/monthly_sales_reports" }

  it "returns status code 200" do
    expect(response).to have_http_status(:success)
  end

  it "returns all reports" do
    expect(JSON.parse(response.body).size).to eq(20)
  end
end
