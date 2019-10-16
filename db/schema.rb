# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_08_040646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "browsers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.boolean "is_done", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "master_lookups", force: :cascade do |t|
    t.string "key"
    t.jsonb "value", default: []
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "you_tubes", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.string "profile_url"
    t.string "cover_url"
    t.string "subscribers"
    t.text "description"
    t.jsonb "emails", default: []
    t.integer "views"
    t.text "joined_at"
    t.string "location"
    t.integer "videos"
    t.jsonb "links", default: {}
    t.boolean "is_crawled", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "test_1_pass"
    t.boolean "test_2_pass"
    t.boolean "test_3_pass"
    t.boolean "test_4_pass"
  end

end
