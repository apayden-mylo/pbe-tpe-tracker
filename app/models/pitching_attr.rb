class PitchingAttr < ApplicationRecord
  belongs_to :player, optional: true

  ATTRIBUTES = {
      'Velocity' => 'velocity',
      'Movement vs LHB' => :move_l,
      'Movement vs RHB' => :move_r,
      'Movement vs. LHB' => :move_l,
      'Movement vs. RHB' => :move_r,
      'Control vs LHB' => :con_l,
      'Control vs RHB' => :con_r,
      'Control vs. LHB' => :con_l,
      'Control vs. RHB' => :con_r,
      'Stamina' => :stamina,
      'Holding Runners' => :hold,
  }.freeze

  def set_attribute(attr, val)
    if ATTRIBUTES[attr]
      send("#{ATTRIBUTES[attr]}=", val)
    end
  end
end
