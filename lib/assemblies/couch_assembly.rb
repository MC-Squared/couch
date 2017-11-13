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

  def one_side
    res = Mattress.new(true)
      .translate(z: 20)

    res += side.translate(x: -$mattress_w/2.0 - $frame_board_w/2.0, y: -($mattress_l/2.0 - $frame_board_l/2.0) - $frame_board_w)
    res += side.translate(x: -$mattress_w/2.0 - $frame_board_w/2.0, y: $mattress_l/2.0 - $frame_board_l/2.0 + $frame_board_w).debug
    res += side.rotate(z: -90)
      .translate(y: $mattress_l/2.0 + $frame_board_w/2.0)

    (0..3).each do |i|
      res += drawer_cube($drawer_w, $drawer_d, $drawer_h)
        .rotate(z: 90)
        .translate(y: -$drawer_w*1.5 + (i * $drawer_w) + (i * 1) - 2)
    end
        #.translate(x: $drawer_w/2.0 + $mattress_l - (i * $drawer_w) - (i * 1), y: $drawer_d/2.0)
    res
  end

  def part(show)
    res = one_side
    res += one_side
      .rotate(z: -90)
      .translate(x: $mattress_l/2.0 + $mattress_w/2.0, y: $mattress_w/2.0)

    res
  end
end
