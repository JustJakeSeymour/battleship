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

  def valid_placement?(ship, coordinates)
    coordinates = coordinates.map {|coordinate| coordinate.upcase}
    # FIRST iterate valid coordinate per coordinate instance
    are_all_coordinates_valid = coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end

    # SECOND test ship size is the same as coordinate length given
    if ship.length != coordinates.size || !are_all_coordinates_valid
      return false
    end

    # NOW splitting up the coordinates to get number and letter arrays
    split_coordinates = coordinates.map do |coordinate|
      coordinate.split('') 
    end
    letters = split_coordinates.map do |coordinate|
      coordinate.first
    end
    numbers = split_coordinates.map do |coordinate|
      coordinate.last.to_i
    end

    # This tests the letters are all the same, and if so the numbers are the range
    if letters.uniq.size == 1
      if (numbers.first..numbers.last).to_a == numbers
        return true
      else
        return false
      end
    # This tests the numbers are all the same, and if so the letters are the range
    elsif numbers.uniq.size == 1
      if (letters.first..letters.last).to_a == letters
        return true
      else
        return false
      end
    else 
      false
    end
  end
  
  def place(ship, coordinates)
    # upcase coordinates for safety
    coordinates = coordinates.map {|coordinate| coordinate.upcase}

    # find that all requested coordinates are empty?
    are_all_coordinates_empty = coordinates.all? do |coordinate|
      @cells[coordinate].empty?
    end
    # invoke verify_placement method on ship / coordinates
    # if passed then verify targeted cells pass empty?
    if !valid_placement?(ship, coordinates) || !are_all_coordinates_empty
      return "That is an invalid placement"
    end
    # if passes tests -> find cell using coordinates & place ship
    coordinates.each {|coordinate| @cells[coordinate].place_ship(ship) }
  end

    # This render method is not to be confused with the render method in the Cell class 
  def render(reveal_ship = false)

    if reveal_ship == true
      board_render_reveal_ships
    else reveal_ship == false
      board_render_hide_ships
    end

  end

  def board_render_reveal_ships
    row_a_keys = @cells.keys.select {|key| key[0] == "A"}
    row_a = row_a_keys.map {|key| @cells[key].render(true)}
    row_b_keys = @cells.keys.select {|key| key[0] == "B"}
    row_b = row_b_keys.map {|key| @cells[key].render(true)}
    row_c_keys = @cells.keys.select {|key| key[0] == "C"}
    row_c = row_c_keys.map {|key| @cells[key].render(true)}
    row_d_keys = @cells.keys.select {|key| key[0] == "D"}
    row_d = row_d_keys.map {|key| @cells[key].render(true)}

    the_board = "  1 2 3 4 \n" + "A #{row_a.join(' ')} \n" + "B #{row_b.join(' ')} \n" + "C #{row_c.join(' ')} \n" + "D #{row_d.join(' ')}"
  end

  def board_render_hide_ships
      row_a_keys = @cells.keys.select {|key| key[0] == "A"}
      row_a = row_a_keys.map {|key| @cells[key].render}
      # Iterate over the cells hash to select all keys that start with B
      row_b_keys = @cells.keys.select {|key| key[0] == "B"}
      row_b = row_b_keys.map {|key| @cells[key].render}
      # Iterate over the cells hash to select all keys that start with C
      row_c_keys = @cells.keys.select {|key| key[0] == "C"}
      row_c = row_c_keys.map {|key| @cells[key].render}
      # Iterate over the cells hash to select all keys that start with D
      row_d_keys = @cells.keys.select {|key| key[0] == "D"}
      row_d = row_d_keys.map {|key| @cells[key].render}

      the_board = "  1 2 3 4 \n" + "A #{row_a.join(' ')} \n" + "B #{row_b.join(' ')} \n" + "C #{row_c.join(' ')} \n" + "D #{row_d.join(' ')}"
    end
end