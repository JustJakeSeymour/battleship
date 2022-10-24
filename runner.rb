require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'

require 'pry'

loop do
  # game variable within loop wipes board, fresh start
  game = Game.new

  game.menu

  game.setup

  # this until block repeats the turn step until all of the ships on one board are sunk
  until game.player_ships_all_sunk? || game.computer_ships_all_sunk?
    game.turn
  end

  game.results
end
# do loop here there Y goes, game.setup -> game.turn loop -> game.results