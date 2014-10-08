require 'json'

class LevelParser
  attr_accessor :file, :level, :data

  def initialize(file)
    @file = file
    @level = Level.new
  end

  def parse!
    @data = JSON.parse(@file.read)

    parse_rings

    @level
  end

  def parse_rings
    @data['rings'].each do |ring|
      position = Vector2d.parse(ring['position'])
      ring_obj = Ring.new(position: position)
      ring['dots'].times do
        ring_obj.trigger
      end
      @level.rings << ring_obj
      @level.dots << ring_obj.dots
    end

    @level.dots.flatten!
  end
end
