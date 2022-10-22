class Game

  def initialize
    @player = Player.new
    # @computer = Computer.new

  end

  def menu

  end

  def setup
    # computer.~board placement method~
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The #{@player.ships[0].name} is three units long and the #{@player.ships[1].name} is two units long."
    @player.board.render
    puts "Enter the squares for the #{@player.ships[0].name} (3 spaces):"
    puts "Separate coordinates by comma (,) only."
    coordinate_gets = gets.to_s
    coordinates = coordinate_gets.split(',')
    @player.placeships(ship, coordinates)
  end
  
  def turn

  end

  def results
    # if computer.ships.all?(sunk?)
    # return "You win!"

    # if player.ships.all?(sunk?)
    # return "I won""

  end

  def setup_text

  end
  
end