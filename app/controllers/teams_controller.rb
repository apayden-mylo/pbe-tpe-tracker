class TeamsController < ApplicationController
  def show
    team = Team.friendly.find(params[:id])
    @title = team.name

    @players = team.players.sort_by { |player| player.tpe }.reverse!
    @total_tpe = @players.sum(&:tpe)
  end
end
