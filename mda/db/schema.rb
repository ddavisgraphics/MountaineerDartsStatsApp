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

ActiveRecord::Schema.define(version: 2020_01_03_131708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accolaids", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.float "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "week"
    t.integer "accolaid"
    t.index ["player_id"], name: "index_accolaids_on_player_id"
    t.index ["season_id"], name: "index_accolaids_on_season_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "team_ids", default: [], array: true
  end

  create_table "high_ins", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "week"
    t.index ["player_id"], name: "index_high_ins_on_player_id"
    t.index ["season_id"], name: "index_high_ins_on_season_id"
  end

  create_table "high_outs", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "week"
    t.index ["player_id"], name: "index_high_outs_on_player_id"
    t.index ["season_id"], name: "index_high_outs_on_season_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.jsonb "results"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "season_id", null: false
    t.integer "week"
    t.index ["season_id"], name: "index_matches_on_season_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "team_id"
    t.boolean "captain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "season_id"
    t.index ["player_id"], name: "index_memberships_on_player_id"
    t.index ["season_id"], name: "index_memberships_on_season_id"
    t.index ["team_id"], name: "index_memberships_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "season_standings", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "season_id", null: false
    t.integer "wins"
    t.integer "losses"
    t.integer "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id"], name: "index_season_standings_on_season_id"
    t.index ["team_id"], name: "index_season_standings_on_team_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.date "start"
    t.date "end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stats501s", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "season_id", null: false
    t.integer "week"
    t.integer "legs_won"
    t.integer "legs_lost"
    t.boolean "match_won"
    t.integer "darts"
    t.integer "points"
    t.integer "average"
    t.integer "ppd"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_stats501s_on_player_id"
    t.index ["season_id"], name: "index_stats501s_on_season_id"
  end

  create_table "stats_choices", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.integer "week"
    t.integer "legs_won"
    t.integer "legs_lost"
    t.boolean "match_won"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_stats_choices_on_player_id"
    t.index ["season_id"], name: "index_stats_choices_on_season_id"
  end

  create_table "stats_crickets", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "player_id", null: false
    t.integer "week"
    t.integer "legs_won"
    t.integer "legs_lost"
    t.boolean "match_won"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_stats_crickets_on_player_id"
    t.index ["season_id"], name: "index_stats_crickets_on_season_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "division_id", null: false
    t.index ["division_id"], name: "index_teams_on_division_id"
  end

  add_foreign_key "accolaids", "players"
  add_foreign_key "accolaids", "seasons"
  add_foreign_key "high_ins", "players"
  add_foreign_key "high_ins", "seasons"
  add_foreign_key "high_outs", "players"
  add_foreign_key "high_outs", "seasons"
  add_foreign_key "matches", "seasons"
  add_foreign_key "season_standings", "seasons"
  add_foreign_key "season_standings", "teams"
  add_foreign_key "stats501s", "players"
  add_foreign_key "stats501s", "seasons"
  add_foreign_key "stats_choices", "players"
  add_foreign_key "stats_choices", "seasons"
  add_foreign_key "stats_crickets", "players"
  add_foreign_key "stats_crickets", "seasons"
  add_foreign_key "teams", "divisions"
end
