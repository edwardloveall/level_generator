root = Dir.pwd
files = ['vector2d',
         'null_ring',
         'simulator',
         'round_simulator',
         'level',
         'ring',
         'dot',
         'level_parser']

files.each do |file|
  require "#{root}/cascade/#{file}"
end

require 'ruby-progressbar'
