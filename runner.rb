require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'

require 'pry'

loop do

  game = Game.new

  game.menu

  game.setup

  until game.player_ships_all_sunk? || game.computer_ships_all_sunk?
    game.turn
  end

  game.results
end
