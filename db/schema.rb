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

ActiveRecord::Schema.define(version: 20160519112256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "iban",         limit: 255
    t.string   "account_name", limit: 255
    t.string   "bic",          limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "type"
    t.decimal  "balance",                    precision: 15, scale: 10, default: 0.0
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.decimal  "sum_per_person",             precision: 15, scale: 10
  end

  add_index "groups", ["creator_id"], name: "index_groups_on_creator_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "text"
    t.integer  "post_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "posts", ["target_type", "target_id"], name: "index_posts_on_target_type_and_target_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "requests", force: :cascade do |t|
    t.decimal  "amount",            precision: 15, scale: 10
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "status_changed_at"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal  "amount",           precision: 15, scale: 10
    t.integer  "transaction_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "source_id"
    t.string   "source_type"
    t.decimal  "balance",          precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["source_type", "source_id"], name: "index_transactions_on_source_type_and_source_id", using: :btree
  add_index "transactions", ["target_type", "target_id"], name: "index_transactions_on_target_type_and_target_id", using: :btree

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
  end

  add_index "user_groups", ["group_id"], name: "index_users_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_users_groups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "email",                limit: 255
    t.string   "secret",               limit: 255
    t.string   "key",                  limit: 255
    t.decimal  "balance",                          precision: 15, scale: 10, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",                limit: 255
    t.string   "encrypted_password",   limit: 255
    t.string   "authentication_token", limit: 255
    t.string   "salt",                 limit: 255
    t.string   "device_token"
    t.string   "encrypted_pin"
  end

  add_foreign_key "posts", "users"
end
