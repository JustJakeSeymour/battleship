class Cell
  attr_reader :coordinates, 
              :ship

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil  
    @fired_upon = false   
  end

  def empty?
    !@ship
  end

  def place_ship(ship)
    @ship = ship
  end
       
  def fired_upon?
    @fired_upon
  end
  
  def fire_upon
    render = false
    @fired_upon = true
    if @ship 
      @ship.hit
    else 
      'Miss!'
    end
  end

  def render(reveal_ship = false)
    return "S" if reveal_ship && !fired_upon? && @ship
    return "." if !fired_upon?
    return "M" if fired_upon? && !@ship
    return "X" if fired_upon? && @ship.sunk?   
    return "H" if fired_upon? && @ship
  end

end