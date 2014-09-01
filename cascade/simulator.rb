class Simulator
  attr_reader :seed, :solutions, :level, :best_solution

  def initialize(seed: seed)
    @seed = seed
    @level = Level.create_from_seed(seed)
    @solutions = @level.triggers.permutation
    @best_solution = @level.triggers
  end

  def simulate
    progress = create_progress_bar
    @solutions.each do |solution|
      round = RoundSimulator.new(solution: solution, seed: @seed)
      solution = round.simulate
      if solution.count < best_solution.count
        best_solution = solution
      end
      progress.increment
    end
    progress.stop
    best_solution
  end

  def create_progress_bar
    triggers_count = @level.triggers.count
    solutions_count = (1..triggers_count).inject(:*)
    ProgressBar.create(title: 'Solving',
                       total: solutions_count,
                       format: '%t (%c/%C): %B %a / %E')
  end
end
