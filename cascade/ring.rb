class Ring
  DOT_DIRECTIONS = [
    Vector2d.up,
    Vector2d.right,
    Vector2d.down,
    Vector2d.left
  ]

  attr_accessor :position, :dots
  attr_reader :exploded

  def initialize(position: Vector2d.new(0, 0), dots: [])
    @position = position
    @dots = dots
    @exploded = false
  end

  def inspect
    "#<Ring @position=#{@position} dots: #{@dots.count}>"
  end

  def trigger(dot: Dot.new)
    add_dot(dot)

    if full?
      explode!
    end
  end

  def add_dot(dot)
    dot.direction = DOT_DIRECTIONS[@dots.count]
    @dots << dot
    dot.ring = self
    dot.position = @position
  end

  def explode!
    @dots.each do |dot|
      dot.detach
    end
    @dots = []
    @exploded = true
  end

  def full?
    @dots.count >= 4
  end

  def exploded?
    @exploded
  end

  def add_random_dots
    rand(0..3).times do
      add_dot(Dot.new)
    end
  end

  def moves_left
    4 - @dots.count
  end
end
