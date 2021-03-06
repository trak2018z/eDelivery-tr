# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171208125451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "postal_code"
    t.string "street"
    t.string "building_number"
    t.string "apartment_number"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cargos", force: :cascade do |t|
    t.bigint "transporter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transporter_id"], name: "index_cargos_on_transporter_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "receipt_date"
    t.datetime "delivery_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_address_id"
    t.bigint "target_address_id"
    t.index ["source_address_id"], name: "index_orders_on_source_address_id"
    t.index ["target_address_id"], name: "index_orders_on_target_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packages", force: :cascade do |t|
    t.integer "weight"
    t.integer "height"
    t.integer "width"
    t.integer "length"
    t.decimal "price"
    t.bigint "cargo_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cargo_id"], name: "index_packages_on_cargo_id"
    t.index ["order_id"], name: "index_packages_on_order_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "full_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.string "code"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "transporters", force: :cascade do |t|
    t.integer "loading_space"
    t.integer "max_weight"
    t.integer "average_speed"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "facebook_uid"
    t.string "google_oauth2_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["facebook_uid"], name: "index_users_on_facebook_uid"
    t.index ["google_oauth2_uid"], name: "index_users_on_google_oauth2_uid"
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cargos", "transporters"
  add_foreign_key "orders", "addresses", column: "source_address_id"
  add_foreign_key "orders", "addresses", column: "target_address_id"
  add_foreign_key "orders", "users"
  add_foreign_key "packages", "cargos"
  add_foreign_key "packages", "orders"
  add_foreign_key "roles", "users"
  add_foreign_key "users", "profiles"
end
