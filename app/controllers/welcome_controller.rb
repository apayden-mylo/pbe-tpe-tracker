class WelcomeController < ApplicationController
  def index
    @pbe_teams = Team.pbe
  end
end
