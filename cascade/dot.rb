class Dot
  attr_reader :position, :ring, :direction

  def initialize(opts = {})
    @position = opts[:position] || Vector2d.new(0, 0)
    @ring = opts[:ring]
    @direction = opts[:direction] || Vector2d.up
  end

  def inspect
    "#<Dot @position=#{@position} @direction=#{@direction}>"
  end

  def detached?
    @ring.nil?
  end

  def detach
    @ring = nil
  end

  def move
    @position += @direction
  end
end
