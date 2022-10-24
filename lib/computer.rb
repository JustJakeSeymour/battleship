require 'pry'
require './lib/board'
require './lib/ship'

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
    chosen_coordinate_to_fire_upon = board.cells.keys.sample

    valid_coordinate = fired_upon_coordinate(chosen_coordinate_to_fire_upon)
    
    player_board.cells[valid_coordinate].fire_upon
  end

  def chosen_coordinate
    @fired_upon_coordinates.last
  end

  def shot_result(coordinate)
    if @board.cells[coordinate].render == 'M'
      "Miss!"
    elsif @board.cells[coordinate].render == 'H'
      "Hit!"
    elsif @board.cells[coordinate].render == 'X'
      "Hit, and sunk the ship!"
    else
      "Error"
    end
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