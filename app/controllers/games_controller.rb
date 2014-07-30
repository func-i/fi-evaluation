class GamesController < ApplicationController

  before_action :load_games

  def bet
    @bet = BetService.new(params, @player)
    @bet.place
    render :show
  end

  def load_games
    @games = Game.all
  end

end