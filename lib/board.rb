class Board

  def initialize
    @cells = {

    "A1" => Cell.new(key)

    }
  end


  def valid_coordinate?(coordinate)

    board.cells.keys.include?(coordinate)
      
    end
    
  end
  
  
end