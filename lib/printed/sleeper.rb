require_relative 'params'

class Sleeper < SolidRuby::Printed
  def initialize(bom=false)
    super(no_bom: !bom)
  end

  def description
    "#{$frame_board_h*10}x#{$frame_board_w*10}mm board: %.2fmm" % $frame_board_l
  end

  def part(_show)
    cube($frame_board_w, $frame_board_l, $frame_board_h).center_xy -
          cube($frame_board_w+1, $frame_board_w+0.2, $frame_board_h/2.0)
          .center_xy
          .translate(
            y: $frame_board_l/2.0 - $frame_board_w/2.0 + 0.1,
            z: $frame_board_h / 2.0 + 0.01
            ) -
          cube($frame_board_w+1, $frame_board_w+0.2, $frame_board_h/2.0)
            .center_xy
            .translate(
              y: -($frame_board_l/2.0 - $frame_board_w/2.0 + 0.1),
              z: -0.01
              )
          #.translate(z: (i-1) * ($frame_board_h + 1)
  end
end
