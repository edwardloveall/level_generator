require 'vector2d'

class Vector2d
  def self.up
    new(0, 1)
  end

  def self.down
    new(0, -1)
  end

  def self.left
    new(-1, 0)
  end

  def self.right
    new(1, 0)
  end

  def inspect
    "(#{x}, #{y})"
  end
end
