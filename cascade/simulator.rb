class Simulator
  attr_reader :seed, :solutions, :current_level

  def initialize(seed)
    @seed = seed
    level = Level.create_from_seed(seed)
    @solutions = level.triggers.permutation
  end

  def simulate
    @solutions.each do |solution|
      round = RoundSimulator.new(solution: solution, seed: @seed)
    end
  end
end
