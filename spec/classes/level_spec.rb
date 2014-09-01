require 'spec_helper'

describe Level do
  describe '.initialize' do
    it 'sets the seed value when passed in' do
      level = Level.new(1)

      expect(level.seed).to eq(1)
    end

    it 'sets a random seed value' do
      level = Level.new

      expect(level.seed).to be
    end
  end

  describe 'self.create_from_seed' do
    it 'sets the seed' do
      seed = 1
      level = Level.create_from_seed(seed)

      expect(level.seed).to eq(seed)
    end
  end

  describe 'self.create_random' do
    it 'calls .fill_randomly!' do
      allow_any_instance_of(Level).to receive(:fill_randomly!)

      Level.create_random
    end
  end

  describe '.fill_randomly!' do
    it 'fills the level with rings' do
      level = Level.new.fill_randomly!
      expect(level.rings.count).to be > 0
    end

    it 'calls .random_ring_count' do
      level = Level.new
      expect(level).to receive(:random_ring_count)
      allow(level).to receive(:random_ring_count).and_return(2)

      level.fill_randomly!
    end
  end

  describe '.mechanic_at' do
    it 'returns the mechanic at a location' do
      level = Level.new
      position = Vector2d.new(2, 3)
      level.rings << Ring.new
      level.rings << ring = Ring.new(position: position)

      expected_ring = level.mechanic_at(position)

      expect(expected_ring).to be(ring)
    end
  end

  describe '.empty!' do
    before(:each) do
      allow(Random).to receive(:new_seed).and_return(1)
      @level = Level.create_random
      @level.empty!
    end

    it 'sets the rings to an empty array' do
      expect(@level.rings).to be_empty
    end

    it 'sets the dots to an empty array' do
      expect(@level.dots).to be_empty
    end
  end

  describe '.moves' do
    it 'displays the number of possible moves' do
      rings = [Ring.new, Ring.new(position: Vector2d.new(1, 0))]
      level = Level.new
      level.rings = rings
      moves = []
      moves.fill(rings.first.position, 0, 4)
      moves.fill(rings.last.position, 4, 4)

      expect(level.triggers).to eq(moves)
    end
  end

  describe '.detached_dots' do
    it 'returns a list of unattached dots' do
      level = Level.create_from_seed(SMALL_LEVEL_SEED)
      level.dots << dot = Dot.new

      expect(level.detached_dots).to match_array(dot)
    end
  end

  describe 'private .create_ring' do
    before(:each) do
      @level = Level.new(4)
      @ring = @level.send(:create_ring)
    end

    it 'creates a ring' do
      expect(@ring).to be_a(Ring)
    end

    it 'adds dots to a ring' do
      expect(@ring.dots).to be_a(Array)
      expect(@ring.dots.first).to be_a(Dot)
    end

    it "doesn't return a ring if another exists in the same position" do
      @level.rings << @ring
      Random.srand(@level.seed)
      ring = @level.send(:create_ring)

      expect(ring).to be_a(NullRing)
    end
  end

  describe 'private .random_ring_count' do
    it 'returns a value in range of 2..34' do
      count = Level.new.send(:random_ring_count)
      expect(count).to be_between(2, 34).inclusive
    end

    it 'returns a value of 2 if the random value created is less than 2' do
      count = Level.new(SMALL_LEVEL_SEED).send(:random_ring_count)

      expect(count).to be(2)
    end
  end
end
