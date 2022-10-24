require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'

require 'pry'

RSpec.describe Game do
### Tests here verify things that can happen in isolation
### Helpers that can prevent o v e r r e a c h i n g

  it 'holds player & computer' do

  end

  # need a test for the  @player.board.place that is called in the #until_valid_placement helper method 
  # This is called initally the #setup on line 34 which then goes into the #until_valid_placement
  # This action does not live in the Player class file so I couldn't test it in player_spec.rb
  # The placing ships action DOES occur in the Computer class so I COULD/DID test for it in computer_spec.rb so no need to write a place ships test for the computer
  
  it 'can set up players board' do

  end
  
  it 'can set up computer board' do

  end
  
  it 'does the set up in single method' do

  end

  it 'shows both boards' do

  end

  it 'has a turn phase' do
    
  end

  it 'has player fire on computer board' do

  end

  it 'has computer fire on player board' do
    
  end

  it 'continues to do turns until either player or computer is all sunk' do

  end
  
  it 'displays game result' do

  end
  
  it 'asks to play again' do

  end
  
  it 'goes to set up method if play again is selected' do

  end

  it 'ends if play again is not selected' do
    
  end
  
end