class DrawerAssembly < SolidRuby::Assembly
  def initialize(args={})
    @drawer_ew = args[:drawer_w] || 90
    @drawer_ed = args[:drawer_d] || 90

    @board_w = args[:board_w] || 2.5
    @board_h = args[:board_h] || 10
    @drawer_gap = args[:gap] || 1

    @handle_h = 2
    @handle_w = 10
    @handle_d = 3
  end
  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def side_panel(x, y, z)
    cube(x, y, z).color("PaleGoldenrod")
  end

  def handle
    cube(@handle_w, @handle_d, @handle_h).color("BurlyWood")
  end

  def part(show)
    @drawer_iw = @drawer_ew - @board_w*2.0 - @drawer_gap*2.0
    @drawer_id = @drawer_ed - @board_w - @drawer_gap

    res = side_panel(@board_w, @drawer_ed - @board_w, @board_h)

    res += side_panel(@board_w, @drawer_ed - @board_w, @board_h)
      .translate(x: @drawer_ew-@board_w)

    res += side_panel(@drawer_ew, @board_w, @board_h)
      .translate(y: @drawer_ed - @board_w)

    res += side_panel(@board_w, @drawer_id-@board_w*2.0, @board_h)
      .translate(x: @board_w + @drawer_gap, y: @board_w)
    res += side_panel(@board_w, @drawer_id-@board_w*2.0, @board_h)
      .translate(x: @drawer_ew - @board_w*2 - @drawer_gap, y: @board_w)
    res += side_panel(@drawer_iw, @board_w, @board_h)
      .translate(x: @board_w + @drawer_gap)
    res += side_panel(@drawer_iw, @board_w, @board_h)
      .translate(x: @board_w + @drawer_gap, y: @drawer_id-@board_w)

    res += cube(@drawer_iw - @board_w, @drawer_id-@board_w, 1)
      .translate(x: @board_w + @drawer_gap + @board_w/2.0, y: @board_w/2.0)
      .color("PeachPuff")

    res += handle
      .translate(x: @drawer_ew/2.0-@handle_w/2.0, z: @board_h/2.0-@handle_h/2.0)
      .translate(y: -@handle_d)

    res.translate(x: -@drawer_ew/2.0, y: -@drawer_ed/2.0)
  end
end
