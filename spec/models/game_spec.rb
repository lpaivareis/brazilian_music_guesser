require "rails_helper"

RSpec.describe Game, type: :model do
  it { is_expected.to validate_presence_of(:player_name) }
  it { is_expected.to validate_inclusion_of(:status).in_array(%w[in_progress completed]) }

  describe "#used_song_ids" do
    let!(:game) { create(:game) }
    let!(:song_a) { create(:song) }
    let!(:song_b) { create(:song) }
    let!(:round_a) { create(:round, game: game, song: song_a) }
    let!(:round_b) { create(:round, game: game, song: song_b) }

    it "reflects the songs used in the game's rounds" do
      expect(game.used_song_ids).to contain_exactly(song_a.id, song_b.id)
    end
  end

  describe "#current_round" do
    let!(:game) { create(:game) }

    context "when there is an existing unanswered round" do
      let!(:round) { create(:round, game: game) }

      it "returns the existing unanswered round" do
        expect(game.current_round).to eq(round)
      end
    end

    context "when there is no unanswered round" do
      let!(:song_a) { create(:song) }
      let!(:song_b) { create(:song) }
      let!(:song_c) { create(:song) }
      let!(:song_d) { create(:song) }

      it "builds a new round" do
        expect { game.current_round }.to change { game.rounds.count }.by(1)
      end
    end
  end

  describe "#finished?" do
    let!(:game) { create(:game) }

    context "with fewer than TOTAL_ROUNDS answered rounds" do
      it "is false" do
        create(:round, game: game, correct: true)
        expect(game.finished?).to be false
      end
    end

    context "with TOTAL_ROUNDS answered rounds" do
      it "is true" do
        Game::TOTAL_ROUNDS.times { create(:round, game: game, song: create(:song), correct: true) }
        expect(game.finished?).to be true
      end
    end
  end

  describe "#complete!" do
    let!(:game) { create(:game, status: "in_progress") }

    it "sets the status to completed" do
      expect { game.complete! }.to change { game.reload.status }.to("completed")
    end
  end
end
