class Team < ApplicationRecord
  has_many :players
  validates_presence_of :name, :league

  enum league: [:pbe, :milpbe]
end
