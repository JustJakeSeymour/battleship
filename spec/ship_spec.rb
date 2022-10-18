require 'pry'
require './lib/ship'

RSpec.describe Ship do 
  it 'has a name' do 
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_instance_of(Ship)
    expect(cruiser.name).to eq("Cruiser")
  end

  it 'ship has a length' do 
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  it 'has a health equal to its length by default' do 
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it 'ship is not sunk by default' do 
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be (false)
  end

  it 'the ship can be hit and the health decreases' do
    cruiser = Ship.new("Cruiser", 3)

    cruiser.hit
      
    expect(cruiser.health).to eq(2)
    expect(cruiser.length).to eq(3)
    expect(cruiser.sunk?).to be(false)
  end

  it 'the ship is sunk when health reaches 0' do
    cruiser = Ship.new("Cruiser", 3)

    cruiser.hit
    cruiser.hit
      
    expect(cruiser.health).to eq(1)
    expect(cruiser.sunk?).to be(false)

    cruiser.hit
    
    expect(cruiser.health).to eq(0)
    expect(cruiser.sunk?).to be(true)
  end
    
end