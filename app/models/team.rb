class Team < ApplicationRecord
  has_many :players
  validates_presence_of :name, :league

  enum league: [:pbe, :milpbe]

  def players
    Player.where(team_id: id)
  end

  def hitters
    Player.hitters.where(team_id: id)
  end

  def pitchers
    Player.pitchers.where(team_id: id)
  end
end
