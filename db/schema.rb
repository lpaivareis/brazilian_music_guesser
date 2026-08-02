# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_02_172006) do
  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "player_name", null: false
    t.integer "score", default: 0, null: false
    t.string "status", default: "in_progress", null: false
    t.datetime "updated_at", null: false
    t.index ["score"], name: "index_games_on_score"
    t.index ["status"], name: "index_games_on_status"
  end

  create_table "rounds", force: :cascade do |t|
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.integer "guessed_song_id"
    t.text "option_song_ids"
    t.integer "song_id", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "song_id"], name: "index_rounds_on_game_id_and_song_id", unique: true
    t.index ["game_id"], name: "index_rounds_on_game_id"
    t.index ["song_id"], name: "index_rounds_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "artist", null: false
    t.integer "clip_end", default: 15, null: false
    t.integer "clip_start", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "difficulty"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "youtube_id", null: false
    t.index ["artist", "title"], name: "index_songs_on_artist_and_title", unique: true
  end

  add_foreign_key "rounds", "games"
  add_foreign_key "rounds", "songs"
end
