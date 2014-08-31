require 'spec_helper'

describe Vector2d do
  describe 'self.up' do
    it 'returns a vector pointing up' do
      vector = Vector2d.up

      expect(vector.to_a).to match_array([0, 1])
    end
  end

  describe 'self.right' do
    it 'returns a vector pointing up' do
      vector = Vector2d.right

      expect(vector.to_a).to match_array([1, 0])
    end
  end

  describe 'self.down' do
    it 'returns a vector pointing up' do
      vector = Vector2d.down

      expect(vector.to_a).to match_array([0, -1])
    end
  end

  describe 'self.left' do
    it 'returns a vector pointing up' do
      vector = Vector2d.left

      expect(vector.to_a).to match_array([-1, 0])
    end
  end

  describe '.inspect' do
    it 'returns a string with x and y' do
      vector = Vector2d.new(2, 3)

      expect(vector.inspect).to eq('(2, 3)')
    end
  end
end
