require 'spec_helper'

describe LevelParser do
  before(:each) do
    @file = File.new('spec/fixtures/level_1.json')
    @parser = LevelParser.new(@file)
    @level = @parser.parse!
  end

  describe '.new' do
    it 'stores the file refences in @file' do
      expect(@parser.file).to eq(@file)
    end
  end

  describe '.parse!' do
    it 'sets an instance of level to @level' do
      expect(@parser.level).to eq(@level)
    end

    it 'sets the parsed file into the data hash' do
      expect(@parser.data).to be_a(Hash)
      expect(@parser.data).to_not be_empty
    end

    it 'calls the parse methods' do
      @file = File.new('spec/fixtures/level_1.json')
      @parser = LevelParser.new(@file)

      expect(@parser).to receive(:parse_rings)

      @parser.parse!
    end
  end

  describe '.parse_rings' do
    it 'adds rings to the level' do
      @parser.parse_rings

      expect(@level.rings).to be_an(Array)
    end

    it 'adds dots to the level' do
      @parser.parse_rings

      expect(@level.dots).to be_an(Array)
    end
  end
end
