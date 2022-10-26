require './lib/player'
require './lib/computer'

require 'pry'

class Game

  attr_reader :player, :computer

  def initialize
    @player = Player.new
    @computer = Computer.new
  end

  def menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."

    input = gets.chomp.upcase
    loop do
      if input == "P"
        return
      elsif input == "Q"
        exit
      else
        puts "Input not recognized. Enter p or q."
        input = gets.chomp.upcase
      end
    end
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
    
    puts @player.board.render(true)
  
    puts "Enter the coordinates for the #{@player.submarine.name} (#{@player.submarine.length} spaces):"
    puts "Separate coordinates by comma (,) only. Do not include spaces."
    
    submarine_coordinates = gets.chomp.split(',')

    until_valid_placement(@player.submarine, submarine_coordinates)
  end
  
  def turn
    both_boards_rendered

    puts "------------------------------\n\n\n"

    puts "Your turn:"
    puts "Enter a coordinate to fire on"
    coordinate = gets.chomp.upcase
    valid_coordinate = @player.fire_upon_computer(coordinate, @computer.board)

    puts "Your shot on #{valid_coordinate} was a #{@computer.shot_result(valid_coordinate)}"

    if computer_ships_all_sunk?
      return
    else
      nil
    end

    @computer.fire_upon_player(@player.board)
    
    puts "My turn:"
    puts "My shot on #{@computer.chosen_coordinate} was a #{@player.shot_result(@computer.chosen_coordinate)}"
  end

  def results
    puts "=🌊=🌊=🌊=🌊=🌊=🌊=🌊=🌊=🌊"
    puts "The results:"
    both_boards_rendered

    if computer_ships_all_sunk?
      puts "You win!"
    end

    if player_ships_all_sunk?
      puts "Computer won!"
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
    until @player.board.are_all_coordinates_empty(player_coordinates)
      puts "Those coordinates are not empty. Please try again:"
      player_coordinates = gets.chomp.upcase.split(',')
    end
    until @player.board.valid_placement?(ship, player_coordinates) # && @player.board.are_all_coordinates_empty(player_coordinates)
      puts "Those are invalid coordinates. Please try again:"
      player_coordinates = gets.chomp.split(',')
    end
    @player.board.place(ship, player_coordinates)
  end

  def both_boards_rendered
    computer_board_title = "COMPUTER BOARD".center(30, '=')
    puts computer_board_title
    puts @computer.board.render
    player_board_title = "PLAYER BOARD".center(30, '=')
    puts player_board_title
    puts @player.board.render(true)    
  end
end