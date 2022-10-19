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
    else 'Miss!'
    end
  end

  def render(reveal_ship = false)
    return "S" if reveal_ship == true
    return "." if @fired_upon == false
    return "M" if @fired_upon == true && @ship == nil
    return "X" if @fired_upon == true && @ship.sunk?   
    return "H" if @fired_upon == true && @ship != nil
  end

end