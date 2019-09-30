class TeamsController < ApplicationController
  include TeamsHelper

  def show
    team = Team.friendly.find(params[:id])
    @title = team.name

    @players = team.players.sort_by { |player| player.tpe }.reverse!
    @total_tpe = @players.sum(&:tpe)
  end

  def index
    @teams = Team.all.select { |team| helpers.active_team?(team.name) }
  end
end
