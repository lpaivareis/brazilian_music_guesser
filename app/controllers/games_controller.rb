class GamesController < ApplicationController
  def new
  end

  def create
    game = Game.create!(player_name: params[:player_name])
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
