class FieldingAttr < ApplicationRecord
  belongs_to :player, optional: true

  ATTRIBUTES = {
      'Fielding Range' => :range,
      'Fielding Error' => :error,
      'Fielding/Catching Arm' => :arm,
      'Turn Double Play' => :dp,
      'Catcher Ability' => :catch
  }.freeze

  def set_attribute(attr, val)
    if ATTRIBUTES[attr]
      send("#{ATTRIBUTES[attr]}=", val)
    end
  end
end
