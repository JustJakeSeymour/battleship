



























#   def valid_placement?(ship, coordinates)
#     coordinates = coordinates.map {|coordinate| coordinate.upcase}

#     length_and_coordinates
#     split_for_testing
#     test_sequential_coordinates  

#   end

#   def are_all_coordinates_valid(ship, coordinates)
#     coordinates.all? do |coordinate|
#     valid_coordinate?(coordinate)
#     end
#   end

#   def length_and_coordinates(ship, coordinates)
#     if ship.length != coordinates.size || !are_all_coordinates_valid
#       return false
#     end
#   end

#   def split_for_testing(ship, coordinates)
#     split_coordinates = coordinates.map do |coordinate|
#       coordinate.split('') 
#     end
#     letters = split_coordinates.map do |coordinate|
#       coordinate.first
#     end
#     numbers = split_coordinates.map do |coordinate|
#       coordinate.last.to_i
#     end
#   end

# def test_sequential_coordinates(ship, coordinates)
#   if letters.uniq.size == 1
#       if (numbers.first..numbers.last).to_a == numbers
#         return true
#       else
#         return false
#       end
#     elsif numbers.uniq.size == 1
#       if (letters.first..letters.last).to_a == letters
#         return true
#       else
#         return false
#       end
#     else 
#       false
#     end
#   end