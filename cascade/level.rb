class Level
  attr_accessor :rings, :dots
  attr_reader :seed

  def initialize(seed = nil)
    @rings = []
    @dots = []
    @seed = seed || Random.new_seed
    Random.srand(@seed)
  end

  def self.create_random
    new.fill_randomly
  end

  def fill_randomly
    ring_count = rand(1..6) * rand(1..5) + rand(-4..4)
    ring_count.times do
      ring = create_ring
      @rings << ring unless ring.is_a?(NullRing)
      @dots << ring.dots unless ring.dots.empty?
    end
    @dots.flatten!
    self
  end

  def empty!
    @rings = []
    @dots = []
  end

  private

  def create_ring
    opts = { position: Vector2d.new(rand(8), rand(8)) }
    ring = Ring.new(opts)
    ring.add_random_dots
    existing_ring = @rings.select { |r| r.position == ring.position }
    if existing_ring.first.nil?
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
