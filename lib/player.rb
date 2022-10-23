require 'pry'
require './lib/board'
require './lib/ship'

class Player
  attr_reader :board, 
              :cruiser, 
              :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3) 
    @submarine = Ship.new("Submarine", 2)
    @fired_upon_coordinates = []
  end

    # player is prompted to give a coordinate
  def fire_upon_computer(coordinate, computer_board)
    # computer_board argument above should be an instance of the computer's board passed in during the turn method in the game class
    valid_coordinate = fired_upon_coordinate(coordinate)
     
    computer_board.cells[valid_coordinate].fire_upon
    # The above will either return "Hit!" or "Miss!" from the fire_upon method in the cell class
  end

  private 

  def fired_upon_coordinate(coordinate) 
    until !@fired_upon_coordinates.include?(coordinate)
      puts "You have already fired upon this coordinate"
      puts "Please enter a new coordinate"
      coordinate = gets.chomp.upcase
    end
    @fired_upon_coordinates << coordinate
    coordinate
  end
  
end