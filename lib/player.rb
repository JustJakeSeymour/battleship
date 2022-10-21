class Player

  attr_reader :board, :ships

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end
  
  # maybe the runner will loop placement until the ship array has been successfully placed. 
  # like an each? for player.ships |ship| choose_placement(ship, GETS COORDINATES)
  def choose_placement(ship, coordinates)
    if @board.valid_placement?(ship, coordinates)
      @board.place(ship, coordinates)
    else
      "Please supply different coordinates."
    end
  end

  # player is prompted to give a coordinate, convert .to_s and apply to computer's board
  def choose_fire_upon(coordinate)
    # log coordinate into an array (maybe that can happen here) <- use this to verify future turn.
    coordinate_history = []
    if @board.valid_coordinate? && !coordinate_history.include?(coordinate)
      # need to confirm how to reach computer variable, scope issue.
      # @@computer.board.cells[coordinate].fire_upon
      coordinate_history << coordinate
    else
      "Please supply different coordinates."
    end
  end

  
end