require 'pry'
require './lib/board'
require './lib/ship'

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

  attr_reader :board, 
              :cruiser, 
              :submarine 

  def initialize 
    @board = Board.new 
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @fired_upon_coordinates = []
  end

  def place_ships 
    @board.place(@cruiser, CRUISER_VALID_PLACEMENTS.sample)
    @board.place(@submarine, SUBMARINE_VALID_PLACEMENTS.sample)
  end
  
  def fire_upon_player(player_board) 
    # player_board argument above should be an instance of the player's board passed in during the turn method in the game class
    chosen_coordinate_to_fire_upon = board.cells.keys.sample

    valid_coordinate = fired_upon_coordinate(chosen_coordinate_to_fire_upon)
    
    player_board.cells[valid_coordinate].fire_upon
    # The above will either return "Hit!" or "Miss!" from the fire_upon method in the cell class
  end

  private

  def fired_upon_coordinate(chosen_coordinate_to_fire_upon) 
    until !@fired_upon_coordinates.include?(chosen_coordinate_to_fire_upon)
      chosen_coordinate_to_fire_upon = board.cells.keys.sample 
    end
    @fired_upon_coordinates << chosen_coordinate_to_fire_upon
    chosen_coordinate_to_fire_upon
  end


end