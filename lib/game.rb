require './lib/player'
require './lib/computer'

require 'pry'

class Game

  def initialize
    @player = Player.new
    @computer = Computer.new

  end

  def menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
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
    # right now, both the computer and the player can win (if it comes down to the very last turn)
    # perhaps we place a check in here to end the turn before player or computer can choose in the event they have been sunk
    puts "My turn:"
    @computer.fire_upon_player(@player.board)
    # Also: it might be better if we use interpolation to say whether the shot was a "hit" or "miss".
    # for some reason the final shot returns "miss" instead of a hit, even though that shot ends the game.
    # MAYBE THIS IS HAPPENING BECAUSE THE FINAL SHOT DOES NOT REGISTER AS A HIT, BECAUSE IT IS CHANGING THE STATUS TO SUNK?
  end

  # results method gives different message based on which board has all sunken ships
  def results
    # it might be nice to show the board at the end of the game, to look at
    puts "=🌊=🌊=🌊=🌊=🌊=🌊=🌊=🌊=🌊"
    puts "The results:"
    both_boards_rendered

    if computer_ships_all_sunk?
      puts "You win!"
      "You win!"
    end

    if player_ships_all_sunk?
      puts "I won."
      "I won."
    end
  end

  def player_ships_all_sunk?
    @player.cruiser.sunk? && @player.submarine.sunk?
  end

  def computer_ships_all_sunk?
    @computer.cruiser.sunk? && @computer.submarine.sunk?
  end

  private 

  def until_valid_placement(ship, player_coordinates)
    until @player.board.valid_placement?(ship, player_coordinates)
      puts "Those are invalid coordinates. Please try again:"
      player_coordinates = gets.chomp.split(',')
    end
    @player.board.place(ship, player_coordinates)
  end

  # Create helper method to use for both_boards_rendered
  def both_boards_rendered
    puts "Enemy board:"
    puts @computer.board.render
    puts "|=========|"
    puts "Your board:"
    puts @player.board.render(true)    
  end
  
end