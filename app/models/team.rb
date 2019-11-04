class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :active, -> { where.not(league: 'free_agent') }

  has_many :players
  validates_presence_of :name, :league

  enum league: [:pbe, :milpbe, :free_agent, :retired]

  def players
    Player.where(team_id: id)
  end

  def hitters
    Player.hitters.where(team_id: id)
  end

  def pitchers
    Player.pitchers.where(team_id: id)
  end

  def total_tpe
    players.sum(&:tpe)
  end

  def normalize_friendly_id(string)
    super.parameterize.underscore
  end
end
