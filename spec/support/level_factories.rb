def small_level
  Level.new(SMALL_LEVEL_SEED).fill_randomly!
end

def single_step_level
  ring_1 = Ring.new
  ring_2 = Ring.new(position: Vector2d.new(0, 1))
  level = Level.new
  level.rings = [ring_1, ring_2]
end
