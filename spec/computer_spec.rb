require 'pry'
require './lib/cell'
require './lib/board'
require './lib/ship'
require './lib/computer'
require './lib/player'

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
    let!(:computer) {Computer.new}
    it 'computer places the ships in valid coordinates' do 

      computer.board.cells.values.all? {|cell| cell.empty?}
      expect(computer.board.cells.values.all? {|cell| cell.empty?}).to be true

      computer.place_ships
      expect(computer.board.cells.values.any? {|cell| !cell.empty?}).to be true

      expect(computer.board.cells.values.select {|cell| !cell.empty?}.size).to eq(5)

      cruiser_cells = computer.board.cells.values.select do |cell|
        cell.ship == computer.cruiser
      end

      sub_cells = computer.board.cells.values.select do |cell|
        cell.ship == computer.submarine
      end
 
      cruiser_coordinates = cruiser_cells.map do |cell|
        cell.coordinates 
      end

      sub_coordinates = sub_cells.map do |cell|
        cell.coordinates
      end
      
      expect(computer.board.valid_placement?(computer.cruiser, cruiser_coordinates)).to be true
      expect(computer.board.valid_placement?(computer.submarine, sub_coordinates)).to be true
    end
  end

  describe '#fire_upon_player' do 
    let!(:computer) {Computer.new}
    it 'can fire upon players board' do 
      player = Player.new

      are_all_cells_empty = player.board.cells.values.all? do |cell|
        cell.empty?
      end

      expect(are_all_cells_empty).to be true

      any_fired_upon_cells = player.board.cells.values.any? do |cell|
        cell.fired_upon?
      end

      expect(any_fired_upon_cells).to be false

      expect(computer.fire_upon_player(player.board)).to eq('Miss!')

      any_fired_upon_cells = player.board.cells.values.any? do |cell|
        cell.fired_upon?
      end

      expect(any_fired_upon_cells).to be true
    end
  end
  
end