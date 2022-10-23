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
    @computer.place_ships
    
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The #{@player.cruiser.name} is #{@player.cruiser.length} units long and the #{@player.submarine.name} is #{@player.submarine.length} units long."
    
    puts @player.board.render
    
    puts "Enter the coordinates for the #{@player.cruiser.name} (#{@player.cruiser.length} spaces):"
    puts "Separate coordinates by comma (,) only. Do not include spaces."
    
    cruiser_coordinates = gets.chomp.split(',')

    until_valid_placement(@player.cruiser, cruiser_coordinates)
    # place_ship is being called in the below helper method
    puts @player.board.render(true)

    puts "Enter the coordinates for the #{@player.submarine.name} (#{@player.submarine.length} spaces):"
    puts "Separate coordinates by comma (,) only. Do not include spaces."
    
    submarine_coordinates = gets.chomp.split(',')

    until_valid_placement(@player.submarine, submarine_coordinates)
  end
  
  def turn
    both_boards_rendered
    puts "Your turn:"
    puts "Enter coord to fire on"
    coord = gets.chomp.upcase
    @player.fire_upon_computer(coord, @computer.board)
    
    puts "My turn:"
    @computer.fire_upon_player(@player.board)

  end

  def results
    # if computer.ships.all?(sunk?)
    # return "You win!"

    # if player.ships.all?(sunk?)
    # return "I won""

  end

  def player_ships_all_sunk?
    @player.cruiser.sunk? && @player.submarine.sunk?
  end

  def computer_ships_all_sunk?
    @computer.cruiser.sunk? && @computer.submarine.sunk?
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

  # Create helper method to use for both_boards_rendered
  def both_boards_rendered
    puts "Enemy board:"
    puts @computer.board.render
    puts "======================"
    puts "Your board:"
    puts @player.board.render(true)    
  end
  
end