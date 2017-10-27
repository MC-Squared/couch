class Side < SolidRuby::Printed
  attr_accessor :board_w, :board_l, :board_h
  def initialize(mattress_w = 1, mattress_l = 1)
    @board_w = 10
    @board_h = 20
    @board_l = (mattress_w + mattress_l + @board_w*4)/3.0
    @board_c = 3 #how many boards
    super()
    BillOfMaterial.bom.add(description)
    BillOfMaterial.bom.add(description)
  end

  def description
    "#{@board_h*10}mmx#{@board_w*10}mm board: %.2fmm" % @board_l
  end

  def part(_show)

    res = nil
    (1..@board_c).each do |i|
      res += (cube(@board_w, @board_l, @board_h).center_xy -
            cube(@board_w+1, @board_w+0.2, @board_h/2.0)
            .center_xy
            .translate(
              y: @board_l/2.0 - @board_w/2.0 + 0.1,
              z: @board_h / 2.0 + 0.01
              ) -
            cube(@board_w+1, @board_w+0.2, @board_h/2.0)
              .center_xy
              .translate(
                y: -(@board_l/2.0 - @board_w/2.0 + 0.1),
                z: -0.01
                )
            ).translate(z: (i-1) * (@board_h + 1))
    end

    res = res.render
    res.color("Sienna")
  end
end
