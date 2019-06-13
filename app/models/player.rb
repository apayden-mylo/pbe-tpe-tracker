class Player < ApplicationRecord
  belongs_to :team

  has_one :fielding_attr
  has_one :hitting_attr
  has_one :pitching_attr

  scope :pitchers, -> { joins(:pitching_attr) }
  scope :hitters, -> { joins(:hitting_attr) }
  scope :fielders, -> { joins(:fielding_attr) }

  POSITIONS = %w(SP CL RP C 1B 2B 3B SS LF CF RF)

  validates :position, presence: true, inclusion: { in: POSITIONS }

  enum throws: { throws_left: 'Left', throws_right: 'Right' }
  enum bats: [:bats_left, :bats_right, :bats_switch]

  def hitter?
    fielding_attr.present? && hitting_attr.present?
  end

  def pitcher?
    pitching_attr.present?
  end
end
