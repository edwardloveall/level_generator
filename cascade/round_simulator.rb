class RoundSimulator
  attr_accessor :solution, :level

  def initialize(solution: nil, seed: nil)
    @solution = solution
    @level = Level.create_from_seed(seed)
  end

  def simulate
    @solution.each_with_index do |move, i|
      trigger_ring(move)
      loop do
        move_dots
        resolve_collisions
        clean_up
        break if @level.detached_dots.empty?
      end
      if complete?
        return i
      end
    end
  end

  def trigger_ring(position)
    ring = @level.mechanic_at(position)
    ring.trigger
  end

  def move_dots
    @level.detached_dots.each do |dot|
      dot.move
    end
  end

  def resolve_collisions
    @level.dots.each do |dot|
      mechanic = @level.mechanic_at(dot.position)
      if !mechanic.nil?
        mechanic.trigger(dot)
      end
    end
  end

  def clean_up
    clean_up_dots
    clean_up_rings
  end

  def clean_up_dots
    @level.dots.delete_if do |dot|
      dot.out_of_bounds?
    end
  end

  def clean_up_rings
    @level.rings.delete_if do |ring|
      ring.exploded?
    end
  end

  def complete?
    @level.rings.empty?
  end
end
