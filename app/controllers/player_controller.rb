class PlayerController < ApplicationController
  def list
    @players = Player.all
  end
end
