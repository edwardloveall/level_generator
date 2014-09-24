# This class should only create and hold state info

class Level
  BOUNDS = Vector2d.new(7, 7)

  attr_accessor :rings, :dots
  attr_reader :seed

  def initialize(seed: nil)
    @rings = []
    @dots = []
    @seed = seed || Random.new_seed
    Random.srand(@seed)
  end

  def self.create_from_seed(seed)
    new(seed: seed).fill_randomly!
  end

  def self.create_random
    new.fill_randomly!
  end

  def fill_randomly!
    ring_count = random_ring_count
    ring_count.times do
      ring = create_ring
      @rings << ring unless ring.is_a?(NullRing)
      @dots << ring.dots unless ring.dots.empty?
    end
    @dots.flatten!
    self
  end

  def mechanic_at(position)
    @rings.select { |r| r.position == position }.shift
  end

  def empty!
    @rings = []
    @dots = []
  end

  def triggers
    @rings.inject([]) do |trigger_array, ring|
      trigger_array.fill(ring.position, trigger_array.count, ring.moves_left)
    end
  end

  def detached_dots
    @dots.select { |dot| dot.detached? }
  end

  def dup
    copy = super
    @rings = copy.rings.dup
    @dots = copy.dots.dup
    copy
  end

  private

  def create_ring
    opts = { position: Vector2d.new(rand(8), rand(8)) }
    ring = Ring.new(opts)
    ring.add_random_dots
    existing_ring = mechanic_at(ring.position)
    if existing_ring.nil?
      return ring
    else
      return NullRing.new
    end
  end

  def random_ring_count
    count = rand(1..6) * rand(1..5) + rand(-4..4)
    [count, 2].max
  end
end
