class Cell
  attr_reader :coordinates, 
              :ship

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil     
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end
        
end