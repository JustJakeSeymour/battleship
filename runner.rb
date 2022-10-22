require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'

require 'pry'

game.menu

game.setup

loop do
game.turn
break if winner

game.results