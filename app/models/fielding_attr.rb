class FieldingAttr < ApplicationRecord
  belongs_to :player, optional: true

  enum archetype: {
      strong_field: 'Strong Arm Fielder',
      balanced: 'Balanced Fielder',
      speedy: 'Speedy Fielder',
      react: 'React Catcher',
      strong_catch: 'Strong Arm Catcher',
      dh: 'Designated Hitter',
      utility: 'Utility Fielder'
  }
end
