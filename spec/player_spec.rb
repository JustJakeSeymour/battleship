require './lib/player'
require './lib/board'
require './lib/cell'
require './lib/ship'
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
    expect(player.ships[0].name).to eq("Cruiser")
    expect(player.ships[1].name).to eq("Submarine")
  end
  
  it 'can place required ships into board' do
    player.choose_placement(player.ships[0], ["A1", "A2", "A3"])
    expect(player.board.cells["A1"].ship).to eq (player.ships[0])
    player.choose_placement(player.ships[1], ["B1", "C1"])
    expect(player.board.cells["C1"].ship).to eq (player.ships[1])
  end
  
  xit 'denies placement if given bad coordinate / ship combo' do
    # binding.pry
    player.choose_placement(player.ships[0], ["A2", "A3"])
    expect(player.board.cells["A1"].ship).to eq (player.ships[0])
    player.choose_placement(player.ships[1], ["B1", "C1"])
    expect(player.board.cells["C1"].ship).to eq (player.ships[1])
  end
  
  it 'keeps prompting for coordinates until new value' do
    
  end
  
  it 'can fire upon the computer board' do

  end
  
  it 'denies coordinates if repeat' do
    
  end  

  it 'keeps prompting for coordinates until new value' do
    
  end

  
end