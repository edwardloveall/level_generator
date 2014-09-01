require 'spec_helper'

describe Dot do
  describe '.initialize' do
    context 'parameters' do
      it 'returns a dot at [2, 3]' do
        position = Vector2d.new(2, 3)
        dot = Dot.new(position: position)

        expect(dot.position).to eq(position)
      end

      it 'returns a dot at its ring position' do
        ring = Ring.new(position: Vector2d.new(3, 4))
        dot = Dot.new(ring: ring)

        expect(dot.position).to eq(ring.position)
      end

      it 'returns a dot with a ring' do
        ring = Ring.new
        dot = Dot.new(ring: ring)

        expect(dot.ring).to eq(ring)
      end

      it 'returns a dot pointing up' do
        direction = Vector2d.up
        dot = Dot.new(direction: direction)

        expect(dot.direction).to eq(direction)
      end
    end
  end

  describe '.inspect' do
    it 'returns a string with position and direction' do
      dot = Dot.new

      expect(dot.inspect).to eq('#<Dot @position=0x0 @direction=0x1>')
    end
  end

  describe '.detached?' do
    it 'returns true when no ring is associated' do
      dot = Dot.new(ring: nil)

      expect(dot).to be_detached
    end

    it 'returns false when a ring is associated' do
      ring = Ring.new
      dot = Dot.new(ring: ring)

      expect(dot).to_not be_detached
    end
  end

  describe '.attached?' do
    it 'returns false when no ring is associated' do
      dot = Dot.new(ring: nil)

      expect(dot).to_not be_attached
    end

    it 'returns true when a ring is associated' do
      ring = Ring.new
      dot = Dot.new(ring: ring)

      expect(dot).to be_attached
    end
  end

  describe '.detach' do
    it 'sets the ring to nil' do
      ring = Ring.new
      dot = Dot.new(ring: ring)

      expect(dot.ring).to be

      dot.detach

      expect(dot.ring).to be_nil
      expect(dot).to be_detached
    end
  end

  describe '.move' do
    it 'moves the dot in its direction once' do
      position = Vector2d.new(3, 4)
      dot = Dot.new(position: position, direction: Vector2d.up)

      dot.move

      expect(dot.position).to eq(Vector2d.new(3, 5))
    end
  end

  describe '.out_of_bounds?' do
    it 'returns false if in bounds' do
      dot = Dot.new(position: Vector2d.new(1, 2))

      expect(dot).to_not be_out_of_bounds
    end

    it 'returns true of out of bounds' do
      dot = Dot.new(position: Vector2d.new(8, -1))

      expect(dot).to be_out_of_bounds
    end
  end
end
