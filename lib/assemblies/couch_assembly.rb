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
      .translate(x: m.y/2.0 + m.x/2.0, y: m.x/2.0 + (m.y/2.0 - m.x))
      .color("PowderBlue")

    # require 'pp'
    # puts "---"
    # pp res



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
      .debug

    res += Side.new(m.x, m.y)
      .rotate(z: 90)
      .translate(x: ((s.board_l - m.x)/2.0) + s.board_l*2 - s.board_w*3, y: back_y)
    res += Side.new(m.x, m.y)
      .translate(x: m.x/2.0+m.y+s.board_w/2.0, y: back_y - s.board_l/2.0)
    # always make sure the lowest statement always returns the object that you're working on
    drawer_w = s.board_l - 10

    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: s.board_h)
      .translate(x: 0, y: m.x/2.0)

    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: s.board_h)
      .translate(x: m.x*2.0, y: m.x/2.0)
    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: s.board_h)
      .translate(x: m.x, y: m.x/2.0)
    res += DrawerAssembly.new(drawer_w: drawer_w, board_h: s.board_h)
      .translate(y: -s.board_l/2.0)

    res
  end
end
