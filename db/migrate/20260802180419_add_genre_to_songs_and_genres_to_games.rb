class AddGenreToSongsAndGenresToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :songs, :genre, :string, null: false, default: ""
    add_index :songs, :genre

    add_column :games, :genres, :text
  end
end
