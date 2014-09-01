require_relative '../cascade'

RSpec.configure do |config|
  config.order = 'random'
end

Dir.glob('spec/support/*.rb').each { |f| require File.expand_path(f) }
