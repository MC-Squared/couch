require_relative 'params'

class Panel < SolidRuby::Printed
  def initialize(x = 1, y = 1)
    @px = x
    @py = y
    @pz = $panel_t

    super() unless x == 1
  end

  def description
    "#{(@px*10).round(2)}x#{(@py*10).round(2)}mm #{$panel_t*10}mm plywood"
  end

  def part(_show)
    cube(@px, @py, @pz).center
  end
end
