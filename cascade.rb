root = Dir.pwd
files = ['cascade/vector2d', 'cascade/level', 'cascade/ring', 'cascade/dot']

files.each do |file|
  require "#{root}/#{file}"
end
