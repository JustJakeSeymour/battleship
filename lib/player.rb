class Player

  attr_reader :board, :ships

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end

  def choose_placement(ship, coordinates)
    # until @board.valid_placement?(ship, coordinates)
    @board.place(ship, coordinates)

  end
end