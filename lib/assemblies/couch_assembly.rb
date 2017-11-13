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

  def part(show)
    m = Mattress.new(true)
    res = m
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
    # always make sure the lowest statement always returns the object that you're working on
    drawer_w = $frame_board_l - 10

    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
      .translate(x: 0, y: $mattress_w/2.0)

    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
      .translate(x: $mattress_w*2.0, y: $mattress_w/2.0)
    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
      .translate(x: $mattress_w, y: $mattress_w/2.0)
    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: $frame_board_h)
      .translate(y: -$frame_board_l/2.0)

    res
  end
end
