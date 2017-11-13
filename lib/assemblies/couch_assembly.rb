require_relative '../printed/params'

class CouchAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.
  def initialize
    super(no_bom: true)
  end
  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def side
    res = nil
    (1..$frame_board_c).each do |i|
      res += Sleeper.new(true).translate(z: (i-1) * ($frame_board_h + 1))
    end

    res = res.render
    res = res.color("Sienna")
  end

  def drawer(x, y, z)
    BoxAssembly.new(x: x, y: y, z: z, top: false, front: true).show
      .color("PeachPuff")
  end

  def drawer_frame(x, y, z)
    BoxAssembly.new(x: x, y: y, z: z, top: true, front: false).show
  end

  def drawer_cube(x, y, z)
    res = drawer_frame(x, y, z)
    res += drawer(
      x - $panel_t*2.0 - $drawer_gap*2.0,
      y - $panel_t - $drawer_gap,
      z - $panel_t*2.0 - $drawer_gap*2.0)
        .translate(y: -($panel_t + $drawer_gap)/2.0, z: $panel_t + $drawer_gap)
  end

  def part(show)
    res = Mattress.new(true)
    res += Mattress.new(true)
      .rotate(z: 90)
      .translate(x: $mattress_l/2.0 + $mattress_w/2.0, y: $mattress_w/2.0 + ($mattress_l/2.0 - $mattress_w))
      .color("PowderBlue")

    res.translate(z: 20)

    s = side.rotate(z: 180)

    back_y = $mattress_w/2.0 + ($mattress_l/2.0 - $mattress_w) + $mattress_w/2.0 + $frame_board_w/2.0

    res += s.translate(x: -$mattress_w/2.0 - $frame_board_w/2.0, y: back_y - $frame_board_l/2.0)
    res += side
      .rotate(z: 90)
      .translate(x: ($frame_board_l - $mattress_w)/2.0 - $frame_board_w, y: back_y) #$mattress_w + $frame_board_w/2.0)
    res += side
      .rotate(z: 90)
      .translate(x: (($frame_board_l - $mattress_w)/2.0) + $frame_board_l - $frame_board_w*2, y: back_y)
      .debug

    res += side
      .rotate(z: 90)
      .translate(x: (($frame_board_l - $mattress_w)/2.0) + $frame_board_l*2 - $frame_board_w*3, y: back_y)
    res += side
      .translate(x: $mattress_w/2.0+$mattress_l+$frame_board_w/2.0, y: back_y - $frame_board_l/2.0)

    (0..3).each do |i|
      res += drawer_cube($drawer_w, $drawer_d, $drawer_h)
        .translate(x: $drawer_w/2.0 + $mattress_l - (i * $drawer_w) - (i * 1), y: $drawer_d/2.0)
    end

    # res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
    #   .translate(x: 0, y: $mattress_w/2.0)
    #
    # res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
    #   .translate(x: $mattress_w*2.0, y: $mattress_w/2.0)
    # res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
    #   .translate(x: $mattress_w, y: $mattress_w/2.0)
    # res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
    #   .translate(y: -$frame_board_l/2.0)

    res
  end
end
