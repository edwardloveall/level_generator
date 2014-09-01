def basic_round
  seed = SMALL_LEVEL_SEED
  @sim = Simulator.new(seed: seed)
  @solution = @sim.solutions.first
  RoundSimulator.new(solution: @solution, seed: seed)
end

def round_with_level(level)
  round = RoundSimulator.new()
  round.level = level
  round
end
