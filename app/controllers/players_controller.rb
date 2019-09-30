class PlayersController < ApplicationController
  def index
    @players = Player.where("team_id != #{Team.find_by_name('Retired').id}").order(tpe: :desc)
  end

  def show
    @player = Player.find(params[:id])
  end
end
