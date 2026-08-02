require "rails_helper"

RSpec.describe Song, type: :model do
  it { is_expected.to validate_presence_of(:artist) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:youtube_id) }

  describe "clip_end validation" do
    it "is invalid when clip_end is not greater than clip_start" do
      song = build(:song, clip_start: 30, clip_end: 30)
      expect(song).not_to be_valid
      expect(song.errors[:clip_end]).to be_present
    end

    it "is valid when clip_end is greater than clip_start" do
      song = build(:song, clip_start: 30, clip_end: 45)
      expect(song).to be_valid
    end
  end

  describe ".excluding_ids" do
    let!(:song_a) { create(:song) }
    let!(:song_b) { create(:song) }

    it "excludes the given ids" do
      expect(Song.excluding_ids([song_a.id])).to contain_exactly(song_b)
    end
  end

  describe ".random_unused_for" do
    let!(:game) { create(:game) }
    let!(:used_song) { create(:song) }
    let!(:unused_song) { create(:song) }
    let!(:round) { create(:round, game: game, song: used_song) }

    it "excludes songs already used by the game" do
      result = Song.random_unused_for(game)
      expect(result).to eq(unused_song)
    end

    it "returns nil when there are no unused songs left" do
      Song.where.not(id: used_song.id).destroy_all
      expect(Song.random_unused_for(game)).to be_nil
    end
  end
end
