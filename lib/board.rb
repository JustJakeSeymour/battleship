require 'pry'
require './lib/cell'

class Board
  attr_reader :cells 

  def initialize 
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    } 
  end
  
  def valid_coordinate?(coordinate)

    @cells.keys.include?(coordinate)
    
  end

  # def valid_placement?(ship, coordinates)
  #   if ship.length == coordinates.count && valid_coordinate?(coordinates)
  #     true
  #   else
  #     false
  #   end
  # end
  
  def valid_placement?(ship, coordinates)
    split_coord = coordinates.map do |coord|
      coord.split('') 
    end
    split_first = split_coord.map do |letter|
      letter.first
    end
    split_last = split_coord.map do |num|
      num.last
    end

    
    # split_coord[0,0] >tested against> range of letters. consecutive || range of numbers. consecutive

    
  end
    
     def range_alpha
       "A".."D".each_cons(ship.length) do |letters|
      array = []
      array << letters 
      end
      array
    end
  binding.pry
end