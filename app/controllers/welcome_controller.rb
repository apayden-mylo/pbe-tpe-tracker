class WelcomeController < ApplicationController
  def index
    @pbe_teams = Team.pbe.order(:name)
    @milpbe_teams = Team.milpbe.order(:name)
  end
end
