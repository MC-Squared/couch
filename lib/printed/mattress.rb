class Mattress < SolidRuby::Printed
  def initialize
    # Here is a good place to define instance variables that make your part parametric.
    # These variables are accessible from outside:
    @x = 92 + 8
    @y = 188 + 12
    @z = 20
    @color = 'Grey'

  end

  def part(_show)
    cube(@x, @y, @z).center_xy.color(@color)
  end

end
