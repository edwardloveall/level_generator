def basic_round
  level = small_level
  @sim = Simulator.new(level: level)
  @solution = @sim.solutions.first
  level = @sim.level
  RoundSimulator.new(solution: @solution, level: level)
end
