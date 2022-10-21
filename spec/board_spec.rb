require 'pry'
require './lib/cell'
require './lib/board'
require './lib/ship'

RSpec.describe Board do 
  describe 'Board class' do 
    let!(:board) {Board.new}

    it 'is an instance of board' do 
      expect(board).to be_instance_of(Board)
    end

    it 'contains 16 cell instances' do 
      expect(board.cells.size).to eq(16)
    end

    it 'holds coordinates as keys' do
      board.cells.keys.each do |key|
        expect(board.cells[key].coordinates).to eq(key)
      end 
    end
  end

  describe 'valid_coordinate? method' do
    let!(:board) {Board.new}

    it 'recognizes coordinates included' do
      expect(board.valid_coordinate?("A1")).to be true
    end

    it 'recognizes coodinates that are not included' do 
      expect(board.valid_coordinate?("X5")).to be false
    end
  end

  describe 'valid_placement? method' do
    let!(:board) {Board.new} 
    let!(:cruiser) {Ship.new("Cruiser", 3)}

    it 'accepts two arguments' do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    end

    it 'accepts a ship object & array of coordinates' do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true 
    end

    it 'returns false if ship length != coordinates' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    end

    it 'confirms coordinates are consecutive' do
      expect(board.valid_placement?(cruiser, ["A1","A2","A3"])).to be true
      expect(board.valid_placement?(cruiser, ["A1","B1","C1"])).to be true
      expect(board.valid_placement?(cruiser, ["A1","A3","A3"])).to be false
      expect(board.valid_placement?(cruiser, ["A1","B1","A3"])).to be false
    end

    it 'can accept lowercase coordinates' do
      expect(board.valid_placement?(cruiser, ["c1","c2","c3"])).to be true
    end

    it 'cannot be diagonal' do
      expect(board.valid_placement?(cruiser, ["A1","B2","C3"])).to be false
    end

    it 'cannot be all the same coordinate' do
      expect(board.valid_placement?(cruiser, ["A1","A1","A1"])).to be false
    end

    it 'does not pass if decending order' do
      expect(board.valid_placement?(cruiser, ["C1","B1","A1"])).to be false
    end
  
    it 'can not place ship in cells not included on the board' do 
      expect(board.valid_placement?(cruiser, ["C4","C5","C6"])).to be false
    end

    it 'can place a ship into cells' do
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.cells["A1"].ship).to eq cruiser
    end

    it 'cannot place two ships into same cell' do
      submarine = Ship.new("Submarine", 2)
     
      board.place(cruiser, ["A1", "A2", "A3"])
      
      expect(board.place(submarine,["A1","B1"])).to eq ("That is an invalid placement")
    end
    
    it 'does holds the same ship object in different coordinates' do
      board.place(cruiser, ["A1", "A2", "A3"])

      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]

      expect(cell_1.ship).to eq cell_2.ship
    end
  end

  describe '#render' do 
    let!(:board) {Board.new} 
    let!(:cruiser) {Ship.new("Cruiser", 3)}

    it 'renders a board' do 

      expect(board.render).to eq("  1 2 3 4 \n" + 
                                 "A . . . . \n" +
                                 "B . . . . \n" + 
                                 "C . . . . \n" + 
                                 "D . . . .")
    end

    it 'renders the board with a ship placed and still hidden' do 
      
      expect(board.render).to eq("  1 2 3 4 \n" + 
                                 "A . . . . \n" +
                                 "B . . . . \n" + 
                                 "C . . . . \n" + 
                                 "D . . . .")

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render).to eq("  1 2 3 4 \n" + 
                                 "A . . . . \n" +
                                 "B . . . . \n" + 
                                 "C . . . . \n" + 
                                 "D . . . .")
    end

    it 'renders the board with a ship placed and visible' do
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render(true)).to eq("  1 2 3 4 \n" + 
                                       "A S S S . \n" +
                                       "B . . . . \n" + 
                                       "C . . . . \n" + 
                                       "D . . . .")
    end

    it 'renders a M when a fired and no ship' do 
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["B3"].fire_upon

      expect(board.render).to eq("  1 2 3 4 \n" + 
                                 "A . . . . \n" +
                                 "B . . M . \n" + 
                                 "C . . . . \n" + 
                                 "D . . . .")
    end
    
    it 'renders a H when a fire_upon hits hidden ship' do
      
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A3"].fire_upon
      expect(board.render).to eq("  1 2 3 4 \n" + 
                                 "A . . H . \n" +
                                 "B . . . . \n" + 
                                 "C . . . . \n" + 
                                 "D . . . .")
    end

    it 'renders a H when a fire_upon hits non hidden ship' do
      
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A3"].fire_upon
      expect(board.render(true)).to eq("  1 2 3 4 \n" + 
                                       "A S S H . \n" +
                                       "B . . . . \n" + 
                                       "C . . . . \n" + 
                                       "D . . . .")
    end
    
    it 'renders an X when a fire_upon hits hidden ship and sinks it' do
      submarine = Ship.new("Submarine", 2)
      board.place(submarine, ["C1", "D1"])

      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A1"].fire_upon
      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon

      expect(board.render).to eq("  1 2 3 4 \n" + 
                                 "A X X X . \n" +
                                 "B . . . . \n" + 
                                 "C . . . . \n" + 
                                 "D . . . .")
    end
    
    it 'renders an X when a fire_upon hits hidden ship and sinks it' do
      submarine = Ship.new("Submarine", 2)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])
      board.cells["A1"].fire_upon
      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon

      expect(board.render(true)).to eq("  1 2 3 4 \n" + 
                                       "A X X X . \n" +
                                       "B . . . . \n" + 
                                       "C S . . . \n" + 
                                       "D S . . .")
    end
  end
end