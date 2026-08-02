require "rails_helper"

RSpec.describe "Rankings", type: :request do
  let!(:low_scorer) { create(:game, status: "completed", score: 10) }
  let!(:high_scorer) { create(:game, status: "completed", score: 90) }
  let!(:in_progress_game) { create(:game, status: "in_progress", score: 50) }

  describe "GET /rankings" do
    it "returns 200 and lists completed games in descending score order" do
      get rankings_path

      expect(response).to have_http_status(:ok)
      expect(response.body.index(high_scorer.player_name)).to be < response.body.index(low_scorer.player_name)
      expect(response.body).not_to include(in_progress_game.player_name)
    end
  end
end
