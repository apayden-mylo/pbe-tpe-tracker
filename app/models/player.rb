class Player < ApplicationRecord
  belongs_to :team

  has_one :fielding_attr
  has_one :hitting_attr
  has_one :pitching_attr

  scope :pitchers, -> { joins(:pitching_attr) }
  scope :hitters, -> { joins(:hitting_attr) }
  scope :hitters, -> { joins(:hitting_attr) }

  enum throws: { throws_left: 'Left', throws_right: 'Right' }
  enum bats: [:bats_left, :bats_right, :bats_switch]
  enum position: {
      'SP': 'Starting Pitcher',
      'CL': 'Closer',
      'RP': 'Middle/Long Relief Pitcher',
      'C': 'Catcher',
      '1B': 'First Base',
      '2B': 'Second Base',
      '3B': 'Third Base',
      'SS': 'Shortstop',
      'LF': 'Left Field',
      'CF': 'Center Field',
      'RF': 'Right Field'
  }

  def hitter?
    fielding_attr.present? && hitting_attr.present?
  end

  def pitcher?
    pitching_attr.present?
  end
end
