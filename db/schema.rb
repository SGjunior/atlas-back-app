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

ActiveRecord::Schema.define(version: 2019_02_26_225143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animal_assignations", force: :cascade do |t|
    t.bigint "grid_id"
    t.bigint "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_animal_assignations_on_animal_id"
    t.index ["grid_id"], name: "index_animal_assignations_on_grid_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "source_href"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cached_views", force: :cascade do |t|
    t.text "payload"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grids", force: :cascade do |t|
    t.string "region"
    t.string "biome"
    t.string "typeof"
    t.string "difficulty"
    t.string "notes"
    t.string "image"
    t.string "source_href"
    t.string "thumbnail_small"
    t.string "thumbnail_medium"
    t.string "row"
    t.integer "index"
    t.index ["region"], name: "index_grids_on_region"
  end

  create_table "islands", force: :cascade do |t|
    t.string "name"
    t.string "source_href"
    t.bigint "grid_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grid_id"], name: "index_islands_on_grid_id"
  end

  create_table "plant_assignations", force: :cascade do |t|
    t.bigint "grid_id"
    t.bigint "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grid_id"], name: "index_plant_assignations_on_grid_id"
    t.index ["plant_id"], name: "index_plant_assignations_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "source_href"
    t.string "typeof"
    t.string "thumbnail_small"
    t.string "thumbnail_medium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ressource_assignations", force: :cascade do |t|
    t.bigint "grid_id"
    t.bigint "ressource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grid_id"], name: "index_ressource_assignations_on_grid_id"
    t.index ["ressource_id"], name: "index_ressource_assignations_on_ressource_id"
  end

  create_table "ressources", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "source_href"
    t.string "thumbnail_small"
    t.string "thumbnail_medium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "animal_assignations", "animals"
  add_foreign_key "animal_assignations", "grids"
  add_foreign_key "islands", "grids"
  add_foreign_key "plant_assignations", "grids"
  add_foreign_key "plant_assignations", "plants"
  add_foreign_key "ressource_assignations", "grids"
  add_foreign_key "ressource_assignations", "ressources"
end
