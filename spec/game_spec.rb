require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'
require './lib/computer'

require 'pry'

RSpec.describe Game do
  let!(:game) {Game.new}

  it 'holds player & computer' do
    expect(game.player).to be_instance_of Player
    expect(game.computer).to be_instance_of Computer
  end
  
  it 'can see if all computer ships have sank' do
    3.times do 
      game.computer.cruiser.hit 
    end

    expect(game.computer_ships_all_sunk?).to be false
    
    2.times do 
      game.computer.submarine.hit
    end

    expect(game.computer_ships_all_sunk?).to be true
  end
  
  it 'can see if all player ships have sank' do
    3.times do
      game.player.cruiser.hit
    end
    
    expect(game.player_ships_all_sunk?).to be false
    
    2.times do
    game.player.submarine.hit
    end

    expect(game.player_ships_all_sunk?).to be true
  end
end