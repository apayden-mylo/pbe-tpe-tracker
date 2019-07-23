class TeamsController < ApplicationController
  def show
    team = Team.friendly.find(params[:id])
    @title = team.name

    @players = team.players.sort_by { |player| player.tpe }.reverse!
  end
end
