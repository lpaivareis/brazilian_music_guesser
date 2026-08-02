require "rails_helper"

RSpec.describe Round, type: :model do
  describe "#options" do
    let!(:song_a) { create(:song) }
    let!(:song_b) { create(:song) }
    let!(:song_c) { create(:song) }
    let!(:game) { create(:game) }
    let!(:round) { create(:round, game: game, song: song_a, option_song_ids: [song_b.id, song_a.id, song_c.id]) }

    it "resolves option_song_ids to Song records in order" do
      expect(round.options).to eq([song_b, song_a, song_c])
    end
  end

  describe "#answered?" do
    let!(:game) { create(:game) }
    let!(:round) { create(:round, game: game) }

    it "is false when correct is nil" do
      expect(round.answered?).to be false
    end

    it "is true once correct has been set" do
      round.update!(correct: true)
      expect(round.answered?).to be true
    end
  end

  describe "#answer!" do
    let!(:game) { create(:game, score: 0) }
    let!(:song) { create(:song) }
    let!(:other_song) { create(:song) }
    let(:round) { create(:round, game: game, song: song, option_song_ids: [song.id, other_song.id]) }

    context "with a correct guess" do
      it "marks the round correct" do
        round.answer!(song.id)
        expect(round.correct).to be true
      end

      it "increments the game's score by 10" do
        expect { round.answer!(song.id) }.to change { game.reload.score }.by(10)
      end
    end

    context "with an incorrect guess" do
      it "marks the round incorrect" do
        round.answer!(other_song.id)
        expect(round.correct).to be false
      end

      it "does not change the game's score" do
        expect { round.answer!(other_song.id) }.not_to(change { game.reload.score })
      end
    end

    context "when called twice" do
      it "is idempotent and does not double-score" do
        round.answer!(song.id)
        expect { round.answer!(other_song.id) }.not_to(change { game.reload.score })
        expect(round.reload.correct).to be true
      end
    end

    context "when it is the last round of the game" do
      let!(:game) { create(:game, status: "in_progress") }
      let!(:last_song) { create(:song) }

      it "completes the game" do
        (Game::TOTAL_ROUNDS - 1).times { create(:round, game: game, song: create(:song), correct: true) }
        last_round = create(:round, game: game, song: last_song, option_song_ids: [last_song.id])

        last_round.answer!(last_song.id)

        expect(game.reload.status).to eq("completed")
      end
    end
  end
end
