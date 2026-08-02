class Round < ApplicationRecord
  belongs_to :game
  belongs_to :song
  serialize :option_song_ids, coder: JSON

  def options
    ids = option_song_ids || []
    songs_by_id = Song.where(id: ids).index_by(&:id)
    ids.filter_map { |id| songs_by_id[id] }
  end

  def answered?
    !correct.nil?
  end

  def answer!(guessed_song_id)
    return self if answered?
    is_correct = guessed_song_id.to_i == song_id
    update!(guessed_song_id: guessed_song_id, correct: is_correct)
    game.increment!(:score, 10) if is_correct
    game.complete! if game.finished?
    self
  end
end
