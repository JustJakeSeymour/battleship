require './lib/player'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'
require 'pry'

RSpec.describe Player do
  let!(:player) {Player.new}
  
  it 'is a Player class' do
    expect(player).to be_a Player    
  end
  
  it 'begins with an empty board' do
    expect(player.board).to be_a Board
  end
  
  it 'begins with required ships' do
    expect(player.cruiser.name).to eq("Cruiser")
    expect(player.submarine.name).to eq("Submarine")
  end

  describe '#fire_upon_coordinate' do 
    let!(:player) {Player.new}
    let!(:computer) {Computer.new}

    it 'can fire upon computers board' do 
      cruiser = Ship.new("Cruiser", 3)

      are_all_cells_empty = computer.board.cells.values.all? do |cell|
        cell.empty?
      end

      expect(are_all_cells_empty).to be true

      any_fired_upon_cells = computer.board.cells.values.any? do |cell|
        cell.fired_upon?
      end

      expect(any_fired_upon_cells).to be false

      expect(player.fire_upon_computer("A1", computer.board)).to eq('Miss!')

      any_fired_upon_cells = computer.board.cells.values.any? do |cell|
        cell.fired_upon?
      end

      expect(any_fired_upon_cells).to be true

      computer.board.place(cruiser, ["A2","A3","A4"])

      expect(player.fire_upon_computer("A3", computer.board)).to eq("Hit!")
    end
  end
  
end