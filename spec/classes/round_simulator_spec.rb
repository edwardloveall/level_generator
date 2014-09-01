require 'spec_helper'

describe RoundSimulator do
  describe '.initialize' do
    it 'sets the move set' do
      round = basic_round

      expect(round.solution).to eq(@solution)
    end
  end

  describe '.simulate' do
    it 'calls all the simulation methods' do
      round = basic_round

      expect(round).to receive(:trigger_ring).
                       and_return(Ring.new).
                       at_least(:once)
      expect(round).to receive(:move_dots).at_least(:once)
      expect(round).to receive(:resolve_collisions).at_least(:once)
      expect(round).to receive(:clean_up).at_least(:once)
      expect(round).to receive(:complete?).at_least(:once)

      round.simulate
    end

    it 'returns the moves it took' do
      solution = [].fill(Vector2d.new(7, 5), 0, 4)
      solution.fill(Vector2d.new(1, 7), 4, 2)
      round = RoundSimulator.new(solution: solution, seed: SMALL_LEVEL_SEED)
      solved_with = round.simulate

      expect(solved_with).to eq(solution)
    end
  end

  describe '.trigger_ring' do
    it 'triggers ring at a specific position' do
      round = basic_round
      ring = round.level.rings.first
      expect(ring).to receive(:trigger)

      round.trigger_ring(position: ring.position)
    end
  end

  describe '.move_dots' do
    it 'moves all the dots by one position' do
      round = basic_round
      round.level.dots << dot = Dot.new

      round.move_dots

      expect(dot.position).to eq(Vector2d.new(0, 1))
    end
  end

  describe '.resolve_collisions' do
    it 'checks all the dots for collisions and acts on them' do
      round = basic_round
      ring = round.level.rings.sample
      round.level.dots << dot = Dot.new(position: ring.position)

      round.resolve_collisions

      expect(ring.dots).to include(dot)
      expect(dot).to be_attached
    end
  end

  describe '.clean_up' do
    it 'calls .clean_up_xxx methods' do
      round = basic_round
      expect(round).to receive(:clean_up_dots)
      expect(round).to receive(:clean_up_rings)

      round.clean_up
    end
  end

  describe '.clean_up_dots' do
    it 'removes all dots from the level that are out of bounds' do
      level = Level.new
      level.dots << Dot.new(position: Vector2d.new(-1, 0))
      round = round_with_level(level)

      round.clean_up_dots

      expect(level.dots).to be_empty
    end
  end

  describe '.clean_up_rings' do
    it 'removes all rings from the level that are exploded' do
      level = Level.new
      level.rings << ring = Ring.new
      ring.explode!
      round = round_with_level(level)

      round.clean_up_rings

      expect(level.rings).to be_empty
    end
  end

  describe '.complete?' do
    it 'is complete when there are no rings left' do
      level = Level.new
      round = round_with_level(level)

      expect(round).to be_complete
    end
  end
end
