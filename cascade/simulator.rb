class Simulator
  attr_reader :seed, :solutions, :current_level

  def initialize(seed)
    @seed = seed
    level = Level.create_from_seed(seed)
    @solutions = level.triggers.permutation
  end

  def simulate
    progress = create_progress_bar
    @solutions.each do |solution|
      round = RoundSimulator.new(solution: solution, seed: @seed)
      progress.increment
    end
    progress.stop

  def create_progress_bar
    triggers_count = @level.triggers.count
    solutions_count = (1..triggers_count).inject(:*)
    ProgressBar.create(title: 'Solving',
                       total: solutions_count,
                       format: '%t (%c/%C): %B %a / %E')
  end
end
