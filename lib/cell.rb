class Cell
  attr_reader :coordinates, 
              :ship

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil  
    @fired_upon = false   
  end

  def empty?
    @ship == nil
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
    if @ship != nil
      @ship.hit
    else 
      'Miss!'
      # You're not supposed to have what you want to happen on the same line as else
    end
  end

  def render(reveal_ship = false)
    return "S" if reveal_ship == true && @fired_upon == false && @ship 
    # return "S" if reveal_ship && !@fired_upon? && @ship
    return "." if !fired_upon?
    return "M" if fired_upon? && !@ship
    return "X" if fired_upon? && @ship.sunk?   
    return "H" if fired_upon? && @ship
  end

end