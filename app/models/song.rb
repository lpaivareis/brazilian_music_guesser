class Song < ApplicationRecord
  GENRES = %w[bossa_nova mpb samba rock_nacional soul_samba axe].freeze

  validates :artist, :title, :youtube_id, presence: true
  validates :clip_end, comparison: { greater_than: :clip_start }
  validates :genre, presence: true, inclusion: { in: GENRES }

  scope :excluding_ids, ->(ids) { where.not(id: ids) }
  scope :by_genres, ->(genres) { genres.present? ? where(genre: genres) : all }

  def self.random_unused_for(game)
    by_genres(game.genres).excluding_ids(game.used_song_ids).order(Arel.sql("RANDOM()")).first
  end
end
