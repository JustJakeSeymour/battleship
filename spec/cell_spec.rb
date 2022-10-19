require './lib/cell'
require './lib/ship'

require 'pry'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("Coordinates")

    expect(cell).to be_a Cell
  end

  it 'returns coordinates' do
    cell = Cell.new("A1")

    expect(cell.coordinates).to eq "A1"
  end

  it 'has ship, but starts empty' do
    cell = Cell.new("A1")

    expect(cell.ship).to be nil
  end

  it 'makes empty? return true at start' do
    cell = Cell.new("A1")

    expect(cell.empty?).to be true
  end

  it 'can add ship with place_ship' do
    cell = Cell.new("A1")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    
    expect(cell.ship).to be cruiser
  end

  it 'will not be empty when ship is added' do
    cell = Cell.new("A1")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.empty?).to be false
  end

  describe '#fire_upon method' do
    it 'has fired_upon? default to false' do
      cell = Cell.new("A1")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to be false
    end

    it 'becomes true when fire_upon is invoked' do
      cell = Cell.new("A1")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to be false

      cell.fire_upon
      expect(cell.fired_upon?).to be true
    end

    it 'removes a ship health' do
      cell = Cell.new("A1")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)

      expect(cell.ship.health).to eq 3

      cell.fire_upon
      expect(cell.ship.health).to eq 2
      expect(cell.fired_upon?).to be true
    end  

    it 'does not need a ship to be targeted' do
      cell = Cell.new("A1")
      
      expect(cell.fired_upon?).to be false

      cell.fire_upon
      expect(cell.fired_upon?).to be true
      
      expect(cell.ship).to be nil
    end
  end

  describe '#render' do 
    # return "." if the cell has not been hit and by default
    it 'returns a character when render is called' do 
      cell_1 = Cell.new("B4")

      expect(cell_1.render).to eq(".")
    end
    # return "M" if cell has been fired up and does NOT contain a ship 
    # if @ship == nil
    it 'returns M when fired upon and do not contain a ship' do 
      cell_1 = Cell.new("B4")

      cell_1.fire_upon

      expect(cell_1.render).to eq("M")
    end
    # return "H" if the cell has been fired upon and DOES contan and ship 
    it 'returns H when fired upon and does contain a ship' do 
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell_1.place_ship(cruiser)
      cell_1.fire_upon

      expect(cell_1.render).to eq("H")
    end
    # return "X" if the cell has been fired upon and its ship has sunk
    it 'returns X when fired upon and ship has been sunk' do 
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 1)

      cell_1.place_ship(cruiser)
      cell_1.fire_upon

      expect(cell_1.render).to eq("X")
      expect(cell_1.ship.sunk?).to be true
    end
    # return "S" when the optional argument is passed
    it 'return S if player requests to see their ships' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 1)
      
      cell_1.place_ship(cruiser)
      
      expect(cell_1.render).to eq(".")

      expect(cell_1.render(true)).to eq("S")

      cell_1.fire_upon 

      expect(cell_1.render(true)).to eq("X")
    end 
  end
end
