require 'pry'
require './lib/cell'
require './lib/board'
require './lib/ship'
require './lib/computer'

RSpec.describe Computer do
  let!(:computer) {Computer.new}

  it 'is a Computer class' do 

    expect(computer).to be_instance_of(Computer)
  end

  it 'begins with an empty board' do 
    
    expect(computer.board).to be_instance_of(Board)
  end

  it 'begins with required ships' do 
    
    expect(computer.cruiser.name).to eq("Cruiser")
    expect(computer.submarine.name).to eq("Submarine")
  end

  describe '#place_ships' do  
    it 'computer places the ships in valid coordinates' do 
      computer = Computer.new

      computer.board.cells.values.all? {|cell| cell.empty?}
      expect(computer.board.cells.values.all? {|cell| cell.empty?}).to be true

      computer.place_ships
      expect(computer.board.cells.values.any? {|cell| !cell.empty?}).to be true

      expect(computer.board.cells.values.select {|cell| !cell.empty?}.size).to eq(5)
    end
  end
end