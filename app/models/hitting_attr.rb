class HittingAttr < ApplicationRecord
  belongs_to :player, optional: true

  ATTRIBUTES = {
      'BABIP vs LHP' => :babip_l,
      'BABIP vs RHP' => :babip_r,
      "Avoid K's vs LHP" => :av_k_l,
      "Avoid K's vs RHP" => :av_k_r,
      'Gap vs LHP' => :gap_l,
      'Gap vs RHP' => :gap_r,
      'Power vs LHP' => :power_l,
      'Power vs RHP' => :power_r,
      'Eye/Patience vs LHP' => :eye_l,
      'Eye/Patience vs RHP' => :eye_r,
      'Speed (Base & Run)' => :speed,
      'Stealing Ability' => :steal,
      'Bunting (Both)' => :bunt
  }.freeze

  def set_attribute(attr, val)
    send("#{ATTRIBUTES[attr]}=", val)
  end
end
