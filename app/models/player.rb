class Player < ApplicationRecord
  belongs_to :team

  has_one :fielding_attr
  has_one :hitting_attr
  has_one :pitching_attr

  scope :pitchers, -> { joins(:pitching_attr) }
  scope :hitters, -> { joins(:hitting_attr) }
  scope :fielders, -> { joins(:fielding_attr) }

  PITCHER_POSITIONS = {
      'SP' => 'Starting Pitcher',
      'CL' => 'Closer',
      'RP' => 'Relief Pitcher'
  }.freeze

  HITTER_POSITIONS = {
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

  POSITIONS = PITCHER_POSITIONS.merge(HITTER_POSITIONS).freeze

  validates :position, presence: true, inclusion: { in: POSITIONS.keys }

  enum throws: { throws_left: 'Left', throws_right: 'Right' }
  enum bats: [:bats_left, :bats_right, :bats_switch]

  def verbose_position
    POSITIONS[position]
  end

  def hitter?
    HITTER_POSITIONS.key?(position) && hitting_attr.present?
  end

  def pitcher?
    PITCHER_POSITIONS.key?(position) && pitching_attr.present?
  end
end
