class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @players = @team.players
  end
end
