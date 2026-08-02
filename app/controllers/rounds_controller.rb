class RoundsController < ApplicationController
  def update
    round = Round.find(params[:id])
    round.answer!(params[:guess_song_id])
    game = round.game
    next_round = game.current_round

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("round", partial: "games/round", locals: { game: game, round: next_round, last_round: round }),
          turbo_stream.replace("score", partial: "games/score", locals: { game: game })
        ]
      end
      format.html { redirect_to game_path(game) }
    end
  end
end
