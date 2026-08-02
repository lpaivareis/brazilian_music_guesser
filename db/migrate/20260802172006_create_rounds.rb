class CreateRounds < ActiveRecord::Migration[8.1]
  def change
    create_table :rounds do |t|
      t.references :game, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
      t.boolean :correct
      t.integer :guessed_song_id
      t.text :option_song_ids # JSON array of 4 song ids shown as choices

      t.timestamps
    end
    add_index :rounds, [ :game_id, :song_id ], unique: true
  end
end
