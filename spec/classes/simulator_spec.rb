require 'spec_helper'

describe Simulator do
  describe '.initialize' do
    it 'takes a level' do
      level = small_level

      sim = Simulator.new(level: level)

      expect(sim.level).to eq(level)
    end

    it 'readies the solutions' do
      level = small_level
      sim = Simulator.new(level: level)
      triggers_count = level.triggers.count
      solutions_count = (1..triggers_count).inject(:*)

      expect(sim.solutions.count).to eq(solutions_count)
    end
  end

  describe '.simulate' do
    before(:each) do
      @level = small_level
      @sim = Simulator.new(level: @level)
      allow_any_instance_of(ProgressBar::Base).to receive(:update)
    end

    it 'creates a new RoundSimulator' do
      expect(RoundSimulator).to receive(:new).
        and_call_original.
        exactly(@sim.solutions.count).times

      @sim.simulate
    end
  end
end
