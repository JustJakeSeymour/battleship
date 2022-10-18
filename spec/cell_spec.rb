require ./lib/ship.rb
require ./lib/cell.rb

RSpec.describe Cell do
  # exists
  it 'exists' do
    cell = Cell.new("Coordinates")

    expect(cell).to be_a Cell
  end

  # coordinate returns "A1"
  it 'returns coordinates' do
    cell = Cell.new("A1")

    expect(cell.coordinates).to eq "A1"
  end

  # has an empty ship spot
  it 'has ship, but starts empty' do
    cell = Cell.new("A1")

    expect(cell.ship).to be nil
  end

  # empty? returns true when no ship
  it 'makes empty? return true at start' do
    cell = Cell.new("A1")

    expect(cell.empty?).to be true
  end

  # place_ship method adds ship to cell
  it 'can add ship with place_ship' do
    cell = Cell.new("A1")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    
    expect(cell.ship).to be cruiser
  end

  # after place_ship is invoked, empty? is false
  it 'will not be empty when ship is added' do
    cell = Cell.new("A1")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.empty?).to be false
  end

end
