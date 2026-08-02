require "rails_helper"

RSpec.describe "Rounds", type: :request do
  let!(:game) { create(:game, score: 0) }
  let!(:song) { create(:song) }
  let!(:other_song) { create(:song) }
  let!(:round) { create(:round, game: game, song: song, option_song_ids: [song.id, other_song.id]) }

  describe "PATCH /rounds/:id" do
    context "with a correct guess" do
      it "returns turbo_stream content and increments the game's score" do
        patch round_path(round), params: { guess_song_id: song.id }, headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(response).to have_http_status(:ok)
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(game.reload.score).to eq(10)
      end
    end

    context "with an incorrect guess" do
      it "does not increment the game's score" do
        patch round_path(round), params: { guess_song_id: other_song.id }, headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(response).to have_http_status(:ok)
        expect(game.reload.score).to eq(0)
      end
    end

    context "when the round has already been answered" do
      it "does not double count the score" do
        patch round_path(round), params: { guess_song_id: song.id }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
        patch round_path(round), params: { guess_song_id: other_song.id }, headers: { "Accept" => "text/vnd.turbo-stream.html" }

        expect(game.reload.score).to eq(10)
      end
    end
  end
end
