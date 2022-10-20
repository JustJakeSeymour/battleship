require 'pry'
require './lib/cell'
require './lib/board'
require './lib/ship'

RSpec.describe Board do 
  describe 'Board class' do 
    it 'is an instance of board' do 
      board = Board.new

      expect(board).to be_instance_of(Board)
    end

    it 'the board contains 16 cell instances' do 
      board = Board.new

      expect(board.cells.size).to eq(16)
      board.cells.keys.each do |key|
        expect(board.cells[key].coordinates).to eq(key)
      end 
    end
  end

  describe 'valid_coordinate? method' do
    it 'can return true' do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be true
    end

    it 'can return false' do
      board = Board.new
      
      
      expect(board.valid_coordinate?("X5")).to be false
    end
  end

  describe 'valid_placement? method' do
    it 'accepts two arguments' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    end
    it 'accepts a ship object & array of coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true 
    end
    it 'returns false if ship length != coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    end
    it 'confirms coordinates are consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.valid_placement?(cruiser, ["A1","A2","A3"])
    end
    # coordinates can be lowercase

    # fails if not sequential

    # fails if diagonal

    # fails if ALL the same coordinate

    # does it pass if backwards?

    # 
  end
end