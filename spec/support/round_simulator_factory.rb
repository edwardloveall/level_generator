def basic_round
  seed = SMALL_LEVEL_SEED
  @sim = Simulator.new(seed: seed)
  @solution = @sim.solutions.first
  level = @sim.level
  RoundSimulator.new(solution: @solution, level: level)
end

def round_with_level(level)
  round = RoundSimulator.new()
  round.level = level
  round
end
