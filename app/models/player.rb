class Player < ApplicationRecord
  belongs_to :team

  has_one :fielding_attr
  has_one :hitting_attr
  has_one :pitching_attr

  scope :pitchers, -> { joins(:pitching_attr) }
  scope :hitters, -> { joins(:hitting_attr) }
  scope :fielders, -> { joins(:fielding_attr) }

  POSITIONS = {
      'SP' => 'Starting Pitcher',
      'CL' => 'Closer',
      'RP' => 'Relief Pitcher',
      'C' => 'Catcher',
      '1B' => 'First Base',
      '2B' => 'Second Base',
      '3B' => 'Third Base',
      'SS' => 'Shortstop',
      'LF' => 'Left Field',
      'CF' => 'Center Field',
      'RF' => 'Right Field',
      'DH' => 'Designated Hitter'
  }.freeze

  validates :position, presence: true, inclusion: { in: POSITIONS.keys }

  enum throws: { throws_left: 'Left', throws_right: 'Right' }
  enum bats: [:bats_left, :bats_right, :bats_switch]

  def verbose_position
    POSITIONS[position]
  end

  def hitter?
    fielding_attr.present? && hitting_attr.present?
  end

  def pitcher?
    pitching_attr.present?
  end
end
