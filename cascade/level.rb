class Level
  attr_accessor :rings, :dots
  attr_reader :seed

  def initialize(seed = nil)
    @rings = []
    @dots = []
    @seed = seed || Random.srand
  end

  def fill_randomly
    ring_count = rand(1..6) * rand(1..5) + rand(-4..4)
    ring_count.times do
      ring = create_ring
      @rings << ring
      @dots << ring.dots unless ring.dots.empty?
    end
    @dots.flatten!
    self
  end

  def empty!
    @rings = []
    @dots = []
  end

  def self.create_random
    new.fill_randomly
  end

  private

  def create_ring
    opts = { position: Vector2d.new(rand(8), rand(8)) }
    ring = Ring.new(opts)
    ring.add_random_dots
    existing_ring = @rings.select { |r| r.position == ring.position }
    existing_ring.first || ring
  end
end
