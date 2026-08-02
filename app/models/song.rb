class Song < ApplicationRecord
  validates :artist, :title, :youtube_id, presence: true
  validates :clip_end, comparison: { greater_than: :clip_start }

  scope :excluding_ids, ->(ids) { where.not(id: ids) }

  def self.random_unused_for(game)
    excluding_ids(game.used_song_ids).order(Arel.sql("RANDOM()")).first
  end
end
