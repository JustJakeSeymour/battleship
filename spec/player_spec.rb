require './lib/player'
require './lib/board'
require './lib/cell'
require 'pry'

RSpec.describe Player do
  let!(:player) {Player.new}
  it 'is a Player class' do
    expect(player).to be_a Player    
  end
  it 'begins with an empty board' do
    expect(player.board).to be_a Board
  end

  
  
  
  
end