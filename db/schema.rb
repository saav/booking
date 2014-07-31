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

ActiveRecord::Schema.define(:version => 20090514123141) do

  create_table "addresses", :force => true do |t|
    t.string   "street",     :null => false
    t.string   "suburb",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.string   "postcode"
  end

  create_table "mydates", :force => true do |t|
    t.string   "date_slug",                    :null => false
    t.integer  "surgeon_id",                   :null => false
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "mytimeslots", :force => true do |t|
    t.string   "time_slug",                      :null => false
    t.text     "content"
    t.boolean  "available",   :default => true
    t.integer  "mydate_id",                      :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "completed",   :default => false
    t.integer  "myorder",                        :null => false
    t.integer  "booker_id"
    t.string   "booker_type"
  end

  create_table "states", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgeon_items", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "description",                   :null => false
    t.float    "cost",        :default => 0.0
    t.integer  "surgeon_id",                    :null => false
    t.boolean  "enabled",     :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "surgeons", :force => true do |t|
    t.string   "first_name",                    :null => false
    t.string   "last_name",                     :null => false
    t.string   "description",                   :null => false
    t.string   "email",                         :null => false
    t.string   "password",                      :null => false
    t.string   "landline",                      :null => false
    t.string   "mobile"
    t.boolean  "enabled",     :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "address_id",                    :null => false
  end

  add_index "surgeons", ["email"], :name => "surgeons_email_index", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name",                   :null => false
    t.string   "last_name",                    :null => false
    t.string   "password",                     :null => false
    t.string   "email",                        :null => false
    t.string   "landline"
    t.string   "mobile"
    t.boolean  "enabled",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id",                   :null => false
  end

  add_index "users", ["email"], :name => "users_email_index", :unique => true

end
