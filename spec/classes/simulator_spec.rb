require 'spec_helper'

describe Simulator do
  describe '.initialize' do
    it 'takes a seed' do
      seed = 1
      sim = Simulator.new(seed)

      expect(sim.seed).to be(seed)
    end

    it 'readies the solutions' do
      seed = SMALL_LEVEL_SEED
      sim = Simulator.new(seed)
      level = Level.create_from_seed(seed)
      triggers_count = level.triggers.count
      solutions_count = (1..triggers_count).inject(:*)

      expect(sim.solutions.count).to eq(solutions_count)
    end
  end

  describe '.simulate' do
    before(:each) do
      seed = SMALL_LEVEL_SEED
      @sim = Simulator.new(seed)
    end

    it 'creates a new RoundSimulator' do
      expect(RoundSimulator).to receive(:new).
        exactly(@sim.solutions.count).times

      @sim.simulate
    end
  end
end
