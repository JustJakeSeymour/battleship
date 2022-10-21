require 'pry'
require './lib/cell'
require './lib/board'
require './lib/ship'
require './lib/computer'

# In the runner files, afte player decides to play, call Computer.new.place_ship 
# this will create the new computer instance AND call on the place ship method all in one go

class Computer 
  CRUISER_VALID_PLACEMENTS = [
    %w(A1 A2 A3),
    %W(A2 A3 A4),
    %W(A1 B1 C1)
  ]

  SUBMARINE_VALID_PLACEMENTS = [
    %w(C2 C3),
    %w(C3 C4),
    %w(C2 D2),
    %w(D3 D4)
  ]

  attr_reader :board, :cruiser, :submarine, :ships 

  def initialize 
    @board = Board.new 
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @ships = [@cruiser, @submarine]
  end

  def place_ships 
    cruiser_place_ship = @board.place(@cruiser, CRUISER_VALID_PLACEMENTS.sample)
    sub_place_ship = @board.place(@submarine, SUBMARINE_VALID_PLACEMENTS.sample)
    success = []
    if cruiser_place_ship.nil?
      success << "Successfully placed cruiser"
    else
      return cruiser_place_ship
    end

    if sub_place_ship.nil? 
      success << "Successfully placed submarine"
    else
      return sub_place_ship
    end
    success
  end
  
end