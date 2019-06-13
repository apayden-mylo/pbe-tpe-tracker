class TeamsController < ApplicationController
  def show
    @team = Team.friendly.find(params[:id])

    @title = @team.name
  end
end
