require "rails_helper"

RSpec.describe Song, type: :model do
  it { is_expected.to validate_presence_of(:artist) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:youtube_id) }
  it { is_expected.to validate_presence_of(:genre) }
  it { is_expected.to validate_inclusion_of(:genre).in_array(Song::GENRES) }

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
      expect(Song.excluding_ids([ song_a.id ])).to contain_exactly(song_b)
    end
  end

  describe ".by_genres" do
    let!(:mpb_song) { create(:song, genre: "mpb") }
    let!(:samba_song) { create(:song, genre: "samba") }
    let!(:axe_song) { create(:song, genre: "axe") }

    it "returns all songs when given an empty array" do
      expect(Song.by_genres([])).to contain_exactly(mpb_song, samba_song, axe_song)
    end

    it "returns all songs when given nil" do
      expect(Song.by_genres(nil)).to contain_exactly(mpb_song, samba_song, axe_song)
    end

    it "returns only songs matching a single genre" do
      expect(Song.by_genres([ "samba" ])).to contain_exactly(samba_song)
    end

    it "returns songs matching any of multiple genres" do
      expect(Song.by_genres([ "samba", "axe" ])).to contain_exactly(samba_song, axe_song)
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
