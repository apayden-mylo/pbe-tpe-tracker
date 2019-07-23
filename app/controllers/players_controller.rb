class PlayersController < ApplicationController
  def index
    @players = Player.order(tpe: :desc)
  end

  def show
    @player = Player.find(params[:id])
  end
end
