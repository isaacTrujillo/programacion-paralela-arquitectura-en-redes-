def sum_squares(squares)
  return false unless squares.respond_to? :each
  total = 0
  squares.each do |square|
    total += square**2
  end
  total
end

puts sum_squares([1, 2, 3])
