#require_relative 'params'

class BoxAssembly < SolidRuby::Assembly
  def initialize(args={})
    @bx = args[:x] || 100
    @by = args[:y] || 200
    @bz = args[:z] || 150

    @front = args[:front] || false
    @top = args[:top] || false
    super(no_bom: true)
  end

  def part(_show)
    # bottom panel
    res = Panel.new(@bx, @by).show
      .translate(z: $panel_t/2.0)

    side_h = @bz - $panel_t*2.0
    # top
    if @top
      res += Panel.new(@bx, @by).show
        .translate(z: @bz - $panel_t/2.0)
    else
      side_h += $panel_t
    end

    #left
    res += Panel.new(side_h, @by).show
      .rotate(y: 90)
      .translate(x: -@bx/2.0 + $panel_t/2.0, z: @bz/2.0)

    #right
    res += Panel.new(side_h, @by).show
      .rotate(y: 90)
      .translate(x: @bx/2.0 - $panel_t/2.0, z: @bz/2.0)

    #front
    if @front
      res += Panel.new(@bx - $panel_t*2.0, side_h).show
        .rotate(x: 90)
        .translate(y: -@by/2.0 + $panel_t/2.0, z: @bz/2.0)
    end
    #back
    res += Panel.new(@bx - $panel_t*2.0, side_h).show
      .rotate(x: 90)
      .translate(y: @by/2.0 - $panel_t/2.0, z: @bz/2.0)
  end
end
