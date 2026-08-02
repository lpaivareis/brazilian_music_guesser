class Game < ApplicationRecord
  serialize :genres, coder: JSON, default: []

  has_many :rounds, dependent: :destroy
  has_many :songs, through: :rounds
  validates :player_name, presence: true
  validates :status, inclusion: { in: %w[in_progress completed] }

  scope :completed, -> { where(status: "completed") }

  TOTAL_ROUNDS = 10

  def used_song_ids
    rounds.pluck(:song_id)
  end

  def current_round
    rounds.where(correct: nil).order(:created_at).first || build_next_round
  end

  def finished?
    rounds.count >= TOTAL_ROUNDS && rounds.where(correct: nil).none?
  end

  def build_next_round
    return nil if rounds.count >= TOTAL_ROUNDS
    song = Song.random_unused_for(self)
    return nil unless song
    distractors = Song.by_genres(genres).excluding_ids(used_song_ids + [ song.id ]).order(Arel.sql("RANDOM()")).limit(3)
    options = ([ song ] + distractors).shuffle
    rounds.create!(song: song, option_song_ids: options.map(&:id))
  end

  def complete!
    update!(status: "completed")
  end
end
