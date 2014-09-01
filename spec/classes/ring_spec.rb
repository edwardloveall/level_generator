require 'spec_helper'

describe Ring do
  describe '.initialize' do
    it 'returns a ring with a position' do
      position = Vector2d.new(2, 3)
      ring = Ring.new(position: position)

      expect(ring.position).to eq(position)
    end

    it "isn't exploded" do
      ring = Ring.new

      expect(ring).to_not be_exploded
    end
  end

  describe '.inspect' do
    it 'returns a string with position and a dot count' do
      ring = Ring.new

      expect(ring.inspect).to eq('#<Ring @position=0x0 dots: 0>')
    end
  end

  describe '.trigger' do
    before(:each) do
      @dot = Dot.new
      @ring = Ring.new(position: Vector2d.new(2, 3))

      @ring.trigger(@dot)
    end

    it 'adds the dot to its array of dots' do
      expect(@ring.dots.first).to be(@dot)
    end

    it "sets the dot's ring to this ring" do
      expect(@ring.dots.first.ring).to be(@ring)
    end

    it "sets the dot's position to the same as the ring" do
      expect(@ring.dots.first.position).to eq(Vector2d.new(2, 3))
    end

    it 'calls .explode' do
      expect(@ring).to receive(:explode!)

      3.times { @ring.trigger }
    end
  end

  describe '.add_random_dots' do
    it 'adds dots to the ring' do
      ring = Ring.new
      Random.srand 3

      ring.add_random_dots

      expect(ring.dots.count).to be(2)
    end
  end

  describe '.explode!' do
    before(:each) do
      @ring = Ring.new
      @ring.trigger
      @dots = @ring.dots

      @ring.explode!
    end

    it 'detaches all the dots' do
      expect(@dots.map(&:ring)).to eq([nil])
    end

    it 'is exploded' do
      expect(@ring).to be_exploded
    end
  end

  describe '.add_dot' do
    before(:each) do
      @dot = Dot.new(direction: Vector2d.down)
      @ring = Ring.new(position: Vector2d.new(3, 4))

      @ring.add_dot(@dot)
    end

    it 'adds the dot to the array of dots' do
      expect(@ring.dots.include?(@dot)).to be_truthy
    end

    it "set's the dots direction" do
      allow(@ring).to receive(:explode!)

      expect(@dot.direction).to eq(Vector2d.up)

      @ring.add_dot(dot = Dot.new)
      expect(dot.direction).to eq(Vector2d.right)

      @ring.add_dot(dot = Dot.new)
      expect(dot.direction).to eq(Vector2d.down)

      @ring.add_dot(dot = Dot.new)
      expect(dot.direction).to eq(Vector2d.left)
    end

    it "sets the dot's ring" do
      expect(@dot.ring).to be(@ring)
    end

    it "sets the dot's position" do
      expect(@dot.position).to eq(@ring.position)
    end
  end

  describe '.full?' do
    before(:each) do
      @ring = Ring.new
    end

    it 'returns true when there are 4 dots' do
      allow(@ring).to receive(:explode!)
      4.times { @ring.trigger }

      expect(@ring).to be_full
    end

    it 'returns false if there are less than 4 dots' do
      3.times { @ring.trigger }

      expect(@ring).to_not be_full
    end
  end

  describe '.moves_left' do
    it 'displays the number of times it can be triggered' do
      ring = Ring.new
      ring.trigger

      expect(ring.moves_left).to eq(3)
    end
  end

  describe '.exploded?' do

  end
end
