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

ActiveRecord::Schema.define(version: 2019_06_13_184318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fielding_attrs", force: :cascade do |t|
    t.integer "range"
    t.integer "error"
    t.integer "arm"
    t.integer "dp"
    t.integer "catch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archetype"
    t.bigint "player_id"
    t.index ["player_id"], name: "index_fielding_attrs_on_player_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "hitting_attrs", force: :cascade do |t|
    t.integer "babip_l"
    t.integer "babip_r"
    t.integer "av_k_l"
    t.integer "av_k_r"
    t.integer "gap_l"
    t.integer "gap_r"
    t.integer "power_l"
    t.integer "power_r"
    t.integer "eye_l"
    t.integer "eye_r"
    t.integer "speed"
    t.integer "steal"
    t.integer "bunt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archetype"
    t.bigint "player_id"
    t.index ["player_id"], name: "index_hitting_attrs_on_player_id"
  end

  create_table "pitching_attrs", force: :cascade do |t|
    t.string "velocity"
    t.integer "move_l"
    t.integer "move_r"
    t.integer "con_l"
    t.integer "con_r"
    t.integer "stamina"
    t.integer "hold"
    t.integer "pitch_1"
    t.integer "pitch_2"
    t.integer "pitch_3"
    t.integer "pitch_4"
    t.integer "pitch_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_id"
    t.index ["player_id"], name: "index_pitching_attrs_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "regression_season"
    t.integer "tpe"
    t.date "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.integer "throws"
    t.integer "bats"
    t.string "position"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league"
    t.string "shorthand"
    t.string "slug"
    t.index ["slug"], name: "index_teams_on_slug", unique: true
  end

  add_foreign_key "players", "teams"
end
