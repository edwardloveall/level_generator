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

  describe 'self.create_random' do
    it 'calls .fill_randomly' do
      allow_any_instance_of(Level).to receive(:fill_randomly)

      Level.create_random
    end
  end

  describe '.fill_randomly' do
    before(:each) do
      @level = Level.create_random
    end

    it 'fills the level with rings' do
      expect(@level.rings.count).to be > 0
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
      count = Level.new(11).send(:random_ring_count)

      expect(count).to be(2)
    end
  end
end
