require_relative 'params'

class Mattress < SolidRuby::Printed
  def initialize(bom=false)
    super(no_bom: !bom)
    @color = 'LightYellow'
  end

  def description
    "#{$mattress_w*10}x#{$mattress_l*10}mm mattress"
  end

  def part(_show)
    cube($mattress_w, $mattress_l, $mattress_h).center_xy.color(@color)
  end
end
