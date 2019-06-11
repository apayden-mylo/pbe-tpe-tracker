class WelcomeController < ApplicationController
  def index
    @pbe_teams = Team.pbe
    @milpbe_teams = Team.milpbe
  end
end
