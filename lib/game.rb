require './lib/player'
require './lib/computer'

require 'pry'

class Game

  def initialize
    @player = Player.new
    @computer = Computer.new

  end

  def menu

  end

  def setup
    # Added the place_ships method for the computer
    @computer.place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    # Updated the string interpolation to match the new attribute style for Player class
    # Add a string interpolation to make the length instruction more dynamic and tied to the ship we are talking about. Same for submarine.
    puts "The #{@player.cruiser.name} is #{@player.cruiser.length} units long and the #{@player.submarine.name} is #{@player.submarine.length} units long."
    @player.board.render
    # Updated string interpolations similar to above
    puts "Enter the coordinates for the #{@player.cruiser.name} (#{@player.cruiser.length} spaces):"
    puts "Separate coordinates by comma (,) only. Do not include spaces."
    # Updated the variable name (since we will receive coords for more than 1 ship) and the gets to include .chomp. Removed .to_s because user input is always received as a string
    cruiser_coordinates = gets.chomp.split(',')
    # coordinates = cruiser_coordinates.split(',')
    # Created an until loop to puts invalid coords messages until they enter valid coords. Can be seen in below helper method
    until_valid_placement(@player.cruiser, cruiser_coordinates)
    # place_ship is being called in the below helper method
    puts @player.board.render(true)

    puts "Enter the coordinates for the #{@player.submarine.name} (#{@player.submarine.length} spaces):"
    puts "Separate coordinates by comma (,) only. Do not include spaces."
    
    submarine_coordinates = gets.chomp.split(',')

    until_valid_placement(@player.submarine, submarine_coordinates)

    puts @player.board.render(true)
  end
  
  def turn
    puts "Enter coord to fire on"
    coord = gets.chomp.upcase
    @player.fire_upon_computer(coord, @computer.board)
    # The above was just so I could test the #fire_upon_computer in Player class. You can remove/update it if you want
    
    # At some point in here, we will call fire_upon_player(@player.board) to fire upon the player's individual cell within their board instance
    # fire_upon_player(@player.board) should return the result of the cell being fired upon (was it a hit or miss?)
    
    # At some point in here, we will call fire_upon_computer(coordinate, @computer.board) the coordinate argument = the coordinate that the player chose to fire upon

  end

  def results
    # if computer.ships.all?(sunk?)
    # return "You win!"

    # if player.ships.all?(sunk?)
    # return "I won""

  end

  def setup_text

  end

  private 

  # Created helper method to use in #setup 
  def until_valid_placement(ship, player_coordinates)
    until @player.board.valid_placement?(ship, player_coordinates)
      puts "Those are invalid coordinates. Please try again:"
      # We need to reset the initial player_coordinates variable so that we can eventually meet the until statement two lines above
      player_coordinates = gets.chomp.split(',')
    end
    @player.board.place(ship, player_coordinates)
  end
  
end