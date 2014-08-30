class Ring
  DOT_DIRECTIONS = [
    Vector2d.up,
    Vector2d.right,
    Vector2d.down,
    Vector2d.left
  ]

  attr_reader :position, :dots

  def initialize(opts = {})
    @position = opts[:position] || Vector2d.new(0, 0)
    @dots = opts[:dots] || []
  end

  def inspect
    "#<Ring @position=#{@position} dots: #{@dots.count}>"
  end

  def add_dot(dot)
    @dots << dot
  end

  def add_random_dots
    rand(4).times do |i|
      opts = {
        ring: self,
        position: @position,
        direction: DOT_DIRECTIONS[i]
      }
      dot = Dot.new(opts)
      dots << dot
    end
  end

  def explode
    dots.each do |dot|
      dot.detach
    end
  end
end
