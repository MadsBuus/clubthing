# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090610200728) do

  create_table "account_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.integer  "account_type_id"
    t.integer  "child_id"
    t.string   "atype"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["account_type_id"], :name => "index_accounts_on_account_type_id"
  add_index "accounts", ["child_id"], :name => "index_accounts_on_child_id"

  create_table "children", :force => true do |t|
    t.string   "name"
    t.integer  "klass_id"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "children", ["klass_id"], :name => "index_children_on_klass_id"
  add_index "children", ["name"], :name => "index_children_on_name"

  create_table "klasses", :force => true do |t|
    t.integer  "startyear"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", :force => true do |t|
    t.integer  "account_id"
    t.integer  "amount"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  add_index "lines", ["account_id"], :name => "index_lines_on_account_id"
  add_index "lines", ["date"], :name => "index_lines_on_date"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
