class Dot
  attr_accessor :position, :ring, :direction

  def initialize(ring: nil,
                 position: Vector2d.new(0, 0),
                 direction: Vector2d.up)
    if @ring = ring
      @position = @ring.position
    else
      @position = position
    end
    @direction = direction
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
