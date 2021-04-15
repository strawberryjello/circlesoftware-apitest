# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_02_080042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_authors_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "apn"
    t.string "description"
    t.decimal "rrp", precision: 7, scale: 2
    t.decimal "last_buy_price", precision: 7, scale: 2
    t.string "product_category"
    t.integer "actual_stock_on_hand"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "monthly_sales_reports", force: :cascade do |t|
    t.datetime "year_and_month"
    t.decimal "total_ex_sales", precision: 13, scale: 2
    t.decimal "gross_profit", precision: 13, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "date_and_time"
    t.string "document_number"
    t.string "reference_number"
    t.integer "quantity"
    t.decimal "total_extax_value", precision: 13, scale: 2
    t.decimal "total_tax", precision: 13, scale: 2
    t.decimal "total_discount_given", precision: 13, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_id", null: false
    t.decimal "profit", precision: 13, scale: 2
    t.index ["item_id"], name: "index_transactions_on_item_id"
  end

  add_foreign_key "authors", "items"
  add_foreign_key "transactions", "items"
end
