require "rails_helper"

RSpec.describe "Games", type: :request do
  describe "POST /games" do
    it "creates a Game and redirects to the game path" do
      expect {
        post games_path, params: { player_name: "Ana" }
      }.to change(Game, :count).by(1)

      expect(response).to redirect_to(game_path(Game.last))
    end

    it "persists the selected genres on the created game" do
      post games_path, params: { player_name: "Ana", genres: [ "mpb", "samba" ] }

      expect(Game.last.genres).to contain_exactly("mpb", "samba")
    end

    it "defaults to an empty genres array when none are given" do
      post games_path, params: { player_name: "Ana" }

      expect(Game.last.genres).to eq([])
    end
  end

  describe "GET /games/:id" do
    let!(:song_a) { create(:song) }
    let!(:song_b) { create(:song) }
    let!(:song_c) { create(:song) }
    let!(:song_d) { create(:song) }
    let!(:game) { create(:game) }

    it "renders successfully and shows round content" do
      get game_path(game)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Tocar trecho")
    end
  end
end
