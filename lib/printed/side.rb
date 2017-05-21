class Side < SolidRuby::Printed
  def initialize(mattress_w = 90, mattress_l = 180)
    @board_w = 5
    @board_h = 20
    @board_l = (mattress_w + mattress_l + board_w*4)/3.0
    @board_c = 3 #how many boards

  end

  def part(_show)
    res = nil
    (1..@board_c).each do |i|
      res += (cube(@board_w, @board_l, @board_h).center_xy -
            cube(@board_w+0.2, @board_w+0.2, @board_h/2.0)
            .center_xy
            .translate(
              x: -0.1,
              y: @board_l/2.0 - @board_w/2.0 + 0.1,
              z: @board_h / 2.0 + 0.01
              ) -
            cube(@board_w+0.2, @board_w+0.2, @board_h/2.0)
              .center_xy
              .translate(
                x: -0.1,
                y: -(@board_l/2.0 - @board_w/2.0 + 0.1),
                z: -0.01
                )
            ).translate(z: (i-1) * (@board_h + 1))
    end


    # res += cube(@board_w+0.2, @board_w+0.2, @board_h/2.0)
    #   .center_xy
    #   .translate(
    #     x: -0.1,
    #     y: -(@board_l/2.0 - @board_w/2.0 + 0.1),
    #     z: -0.01
    #     )
    #  .color("RED")
    res
  end
end
