class CreateSongs < ActiveRecord::Migration[8.1]
  def change
    create_table :songs do |t|
      t.string :artist, null: false
      t.string :title, null: false
      t.string :youtube_id, null: false
      t.integer :clip_start, null: false, default: 0
      t.integer :clip_end, null: false, default: 15
      t.string :difficulty

      t.timestamps
    end
    add_index :songs, [:artist, :title], unique: true
  end
end
