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

ActiveRecord::Schema.define(version: 20150209000324) do

  create_table "events", force: :cascade do |t|
    t.integer  "blogto_id"
    t.string   "title"
    t.text     "body"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "venue"
    t.string   "address"
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
