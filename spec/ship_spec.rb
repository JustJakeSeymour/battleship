require 'pry'
require './lib.ship'

RSpec.describe Ship do 
    it 'has a name' do 
        cruiser = Ship.new("Cruiser", 3)

        expect(ship.name).to eq("Cruiser")
    end
end