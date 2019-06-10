class HittingAttr < ApplicationRecord
  belongs_to :player, optional: true

  enum archetype: {
      speed: 'Speed Demon',
      contact: 'Contact Hitter',
      balanced: 'Balanced Batter',
      power: 'Power Hitter',
  }
end
