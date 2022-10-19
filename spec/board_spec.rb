require 'pry'
require './lib/cell'
require './lib/board'

RSpec.describe 'valid_coordinate' do 
  it 'can return true' do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to be true
  end

  it 'can return false' do
    board = Board.new
    
    
    expect(board.valid_coordinate?("X5")).to be false
  end
end