class RankingsController < ApplicationController
  def index
    @top_games = Game.completed.order(score: :desc).limit(20)
  end
end
