class GamesController < ApplicationController
  def new
    @genres = Song::GENRES
  end

  def create
    selected_genres = Array(params[:genres]).reject(&:blank?)
    game = Game.create!(player_name: params[:player_name], genres: selected_genres)
    redirect_to game_path(game)
  end

  def show
    @game = Game.find(params[:id])
    @round = @game.current_round
    if @round.nil?
      @game.complete!
      redirect_to rankings_path and return
    end
  end
end
