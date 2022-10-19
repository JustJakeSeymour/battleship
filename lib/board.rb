class Board

  attr_reader :cells
  
  def initialize
    @cells = {

    "A1" => Cell.new("A1")

    }
  end


  def valid_coordinate?(coordinate)

    @cells.keys.include?(coordinate)
    
  end

  def valid_placement?
  end
  
  
end