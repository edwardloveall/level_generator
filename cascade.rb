root = Dir.pwd
files = ['vector2d',
         'null_ring',
         'simulator',
         'round_simulator',
         'level',
         'ring',
         'dot']

files.each do |file|
  require "#{root}/cascade/#{file}"
end
