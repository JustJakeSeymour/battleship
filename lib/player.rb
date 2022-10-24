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

  def fire_upon_computer(coordinate, computer_board)
    until @board.valid_coordinate?(coordinate)
      puts "That is not a valid coordinate"
      puts "Please enter a new coordinate"
      coordinate = gets.chomp.upcase
    end

    valid_coordinate = fired_upon_coordinate(coordinate)
     
    computer_board.cells[valid_coordinate].fire_upon
  end

   def shot_result(chosen_coordinate)
    if @board.cells[chosen_coordinate].render == 'M'
      "Miss!"
    elsif @board.cells[chosen_coordinate].render == 'H'
      "Hit!"
    elsif @board.cells[chosen_coordinate].render == 'X'
      "Hit, and sunk the ship!"
    else
      "Error"
    end
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