# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141120090957) do

  create_table "actions", force: true do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "body_classes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", force: true do |t|
    t.string   "initial"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_infos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_stages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buy_reasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "call_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_assesses", force: true do |t|
    t.integer  "car_info_id"
    t.string   "assess_appearance"
    t.string   "assess_skeletons"
    t.string   "assess_interior"
    t.string   "assess_engine"
    t.string   "assess_transmission"
    t.string   "assess_comprehensive"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_configurations", force: true do |t|
    t.integer  "car_info_id"
    t.string   "standard"
    t.string   "safety"
    t.string   "comfort"
    t.string   "function"
    t.string   "other"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_infos", force: true do |t|
    t.string   "car_no"
    t.string   "saletype"
    t.string   "brand"
    t.string   "series"
    t.string   "vin"
    t.string   "engineid"
    t.string   "platenumber"
    t.string   "models"
    t.string   "ownername"
    t.string   "ownerphone"
    t.string   "newsfrom"
    t.integer  "cooperation_id"
    t.string   "location"
    t.string   "rating"
    t.decimal  "customer_offer",                 precision: 20, scale: 2
    t.decimal  "evaluate_price",                 precision: 20, scale: 2
    t.decimal  "procurement_price",              precision: 20, scale: 2
    t.decimal  "newcar_price",                   precision: 20, scale: 2
    t.decimal  "suggested_price",                precision: 20, scale: 2
    t.decimal  "maintenance_budget",             precision: 20, scale: 2
    t.decimal  "selllimit_price",                precision: 20, scale: 2
    t.decimal  "price_hand",                     precision: 20, scale: 2
    t.text     "description",        limit: 255
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "depot_time"
    t.datetime "sell_time"
    t.integer  "customer_id"
    t.integer  "sell_way_id"
    t.decimal  "deal_price",                     precision: 20, scale: 2
    t.integer  "payment_method_id"
    t.integer  "sell_user_id"
    t.datetime "selloff_time"
    t.integer  "depot_id"
  end

  create_table "car_nos", force: true do |t|
    t.integer  "no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_photos", force: true do |t|
    t.integer  "car_info_id"
    t.integer  "photo_style"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "car_properties", force: true do |t|
    t.integer  "car_info_id"
    t.string   "transmission"
    t.string   "cc"
    t.string   "cc_unit"
    t.string   "transfer_number"
    t.datetime "production_date"
    t.datetime "registration_date"
    t.string   "registration_province"
    t.string   "registration_city"
    t.string   "registration_district"
    t.decimal  "mileage",               precision: 10, scale: 2
    t.decimal  "maintenance_mileage",   precision: 10, scale: 2
    t.string   "color"
    t.string   "interior_color"
    t.string   "body_class"
    t.string   "emission_standard"
    t.integer  "with_plate_number"
    t.string   "use_nature"
    t.string   "insurance_info"
    t.datetime "inspection_expire"
    t.datetime "compulsory_expire"
    t.string   "compulsory_company"
    t.string   "business_info"
    t.datetime "business_expire"
    t.string   "business_company"
    t.string   "insurance_record"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_sorts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cc_units", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comforts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compulsory_companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cooperate_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cooperate_relations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cooperate_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cooperations", force: true do |t|
    t.integer  "cooperate_type_id"
    t.string   "name"
    t.string   "rule"
    t.integer  "cooperate_relation_id"
    t.integer  "cooperate_level_id"
    t.string   "contact"
    t.string   "phone"
    t.datetime "period_start"
    t.datetime "period_end"
    t.string   "describe"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_needs", force: true do |t|
    t.string   "brand"
    t.string   "series"
    t.string   "models"
    t.string   "brand_others"
    t.string   "color"
    t.string   "interior_color"
    t.string   "transmission"
    t.integer  "car_sort_id"
    t.decimal  "cc_min",                precision: 20, scale: 2
    t.decimal  "cc_max",                precision: 20, scale: 2
    t.string   "cc_unit"
    t.decimal  "mileage_min",           precision: 20, scale: 2
    t.decimal  "mileage_max",           precision: 20, scale: 2
    t.decimal  "car_age_min",           precision: 20, scale: 2
    t.decimal  "car_age_max",           precision: 20, scale: 2
    t.decimal  "expectative_price_min", precision: 20, scale: 2
    t.decimal  "expectative_price_max", precision: 20, scale: 2
    t.string   "transfer_area"
    t.string   "platenumber_demand"
    t.integer  "is_mortgage"
    t.string   "mortgage_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "customer_nos", force: true do |t|
    t.integer  "no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_others", force: true do |t|
    t.integer  "experience_id"
    t.integer  "buy_reason_id"
    t.string   "undeal_reason"
    t.string   "seen_models"
    t.string   "fit_models"
    t.string   "newsfrom"
    t.integer  "network_id"
    t.integer  "tag_id"
    t.integer  "business_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "customer_sorts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.integer  "sort_id"
    t.string   "no"
    t.string   "name"
    t.string   "phone"
    t.string   "weixin"
    t.string   "address"
    t.datetime "call_time"
    t.integer  "call_type_id"
    t.integer  "sex"
    t.string   "id_number"
    t.datetime "birthday"
    t.integer  "age_id"
    t.integer  "industry_id"
    t.integer  "duty_id"
    t.integer  "income_id"
    t.integer  "status"
    t.datetime "plan_deal_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "addtime"
    t.datetime "visit_date"
    t.string   "other"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "depots", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emission_standards", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followup_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followups", force: true do |t|
    t.integer  "followup_type_id"
    t.string   "content"
    t.string   "next_content"
    t.datetime "next_time"
    t.integer  "followupable_id"
    t.string   "followupable_type"
    t.integer  "is_finished"
    t.integer  "user_id"
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "has_next"
    t.integer  "state"
    t.string   "cancel_reason"
  end

  create_table "functions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interior_colors", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsfroms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

  create_table "pay_reasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_details", force: true do |t|
    t.integer  "payment_id"
    t.integer  "pay_reason_id"
    t.decimal  "cost",            precision: 10, scale: 2
    t.string   "remark"
    t.integer  "payments_way_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_methods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "car_info_id"
    t.integer  "user_id"
    t.decimal  "cost",        precision: 10, scale: 2
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments_ways", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_logs", force: true do |t|
    t.integer  "car_info_id"
    t.string   "describe"
    t.string   "reason"
    t.datetime "addtime"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_ref_histories", force: true do |t|
    t.integer  "price_ref_id"
    t.decimal  "price",        precision: 20, scale: 2
    t.datetime "price_date"
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_ref_offs", force: true do |t|
    t.integer  "price_ref_id"
    t.decimal  "price",        precision: 20, scale: 2
    t.datetime "price_date"
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_refs", force: true do |t|
    t.string   "brand"
    t.string   "series"
    t.integer  "year"
    t.integer  "standard_id"
    t.decimal  "price_newcar",  precision: 20, scale: 2
    t.decimal  "price_buy",     precision: 20, scale: 2
    t.text     "configuration"
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proceeds", force: true do |t|
    t.integer  "car_info_id"
    t.integer  "user_id"
    t.decimal  "cost",        precision: 10, scale: 2
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proceeds_details", force: true do |t|
    t.integer  "proceeds_id"
    t.integer  "proceeds_reason_id"
    t.decimal  "cost",               precision: 10, scale: 2
    t.string   "remark"
    t.integer  "payments_way_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proceeds_reasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repair_details", force: true do |t|
    t.integer  "repair_id"
    t.string   "item"
    t.decimal  "cost",           precision: 20, scale: 2
    t.string   "remark"
    t.integer  "is_cooperation"
    t.integer  "cooperation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repairs", force: true do |t|
    t.integer  "car_info_id"
    t.integer  "style"
    t.decimal  "man_hour",    precision: 10, scale: 2
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "cost"
    t.integer  "status"
    t.string   "remark"
    t.datetime "addtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "check"
  end

  create_table "safeties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saletypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sell_ways", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", force: true do |t|
    t.integer  "brand_id"
    t.string   "initial"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "standards", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transmissions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "use_natures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_depots", force: true do |t|
    t.integer  "user_id"
    t.integer  "depot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_powers", force: true do |t|
    t.integer  "user_id"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "department_id"
    t.string   "name"
    t.string   "account"
    t.string   "pwd"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tip_id"
  end

end
