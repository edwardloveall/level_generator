class Dot
  attr_accessor :position, :ring, :direction

  def initialize(opts = {})
    @ring = opts[:ring]
    if @ring
      @position = @ring.position
    else
      @position = opts[:position] || Vector2d.new(0, 0)
    end
    @direction = opts[:direction] || Vector2d.up
  end

  def inspect
    "#<Dot @position=#{@position} @direction=#{@direction}>"
  end

  def detached?
    @ring.nil?
  end

  def attached?
    !detached?
  end

  def detach
    @ring = nil
  end

  def move
    @position += @direction
  end

  def out_of_bounds?
    if position.x > Level::BOUNDS.x ||
       position.x < 0 ||
       position.y > Level::BOUNDS.y ||
       position.y < 0
      return true
    else
      return false
    end
  end
end
