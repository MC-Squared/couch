class CouchAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def part(show)
    m = Mattress.new
    res = m
    res += Mattress.new
      .rotate(z: 90)
      .translate(x: m.y/2.0 + m.x/2.0, y: m.x/2.0 + (m.y/2.0 - m.x), z: 2)
      .color("BLUE")
    res.translate(z: 20)

    s = Side.new(m.x, m.y).rotate(z: 180)

    back_y = m.x/2.0 + (m.y/2.0 - m.x) + m.x/2.0 + s.board_w/2.0

    res += s.translate(x: -m.x/2.0 - s.board_w/2.0, y: back_y - s.board_l/2.0)
    res += Side.new(m.x, m.y)
      .rotate(z: 90)
      .translate(x: (s.board_l - m.x)/2.0 - s.board_w, y: back_y) #m.x + s.board_w/2.0)
    res += Side.new(m.x, m.y)
      .rotate(z: 90)
      .translate(x: ((s.board_l - m.x)/2.0) + s.board_l - s.board_w*2, y: back_y)
    res += Side.new(m.x, m.y)
      .rotate(z: 90)
      .translate(x: ((s.board_l - m.x)/2.0) + s.board_l*2 - s.board_w*3, y: back_y)
    res += Side.new(m.x, m.y)
      .translate(x: m.x/2.0+m.y+s.board_w/2.0, y: back_y - s.board_l/2.0)
    # always make sure the lowest statement always returns the object that you're working on

    res += DrawerAssembly.new(drawer_w: s.board_l - 5, board_h: 20)
      .translate(x: 195, y: 45)
    res += DrawerAssembly.new(drawer_w: s.board_l - 5, board_h: 20)
      .translate(x: 90, y: 45)
    res
  end
end
