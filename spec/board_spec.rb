require 'pry'
require './lib/cell'
require './lib/board'

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

end