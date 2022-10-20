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

      expect(board.valid_placement?(cruiser, ["A1","A2","A3"])).to be true
      expect(board.valid_placement?(cruiser, ["A1","B1","C1"])).to be true
      expect(board.valid_placement?(cruiser, ["A1","A3","A3"])).to be false
      expect(board.valid_placement?(cruiser, ["A1","B1","A3"])).to be false
    end
    # coordinates can be lowercase
    it 'can accept lowercase coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["c1","c2","c3"])).to be true
    end
    # fails if diagonal
    it 'cannot be diagonal' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      
      expect(board.valid_placement?(cruiser, ["A1","B2","C3"])).to be false
    end
    # fails if ALL the same coordinate
    it 'cannot be all the same coordinate' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1","A1","A1"])).to be false
    end
    # does it pass if backwards?
    it 'does not pass if decending order' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["C1","B1","A1"])).to be false
    end
    it 'can place a ship into cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
     
      board.place(cruiser, ["A1", "A2", "A3"])
      
      expect(board.cells["A1"].ship).to eq cruiser
    end
    it 'cannot place two ships into same cell' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
     
      board.place(cruiser, ["A1", "A2", "A3"])
      
      expect(board.place(submarine,["A1","B1"])).to be false
    end
    it 'does holds the same ship object in different coordinates' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]

      expect(cell_1.ship).to eq cell_2.ship
    end
  end
end