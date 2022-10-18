require ./lib/ship.rb

class Cell

    attr_reader :coordinates, :empty?, :ship

    def initialize(coordinates)
        @coordinates = coordinates
        @ship = []
        
    end
    
    def empty?
        @ship == nil
    end

    def place_ship(ship)
        @ship << ship
    end
    
end