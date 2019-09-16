class PlayersController < ApplicationController
  def index
    @players = Player.where('team_id != 7 AND team_id != 10').order(tpe: :desc)
  end

  def show
    @player = Player.find(params[:id])
  end
end
