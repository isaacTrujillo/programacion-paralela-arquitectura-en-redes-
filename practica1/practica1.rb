def palindrome?(text)
  return false unless text.respond_to? :each_char
  second = text.size - 1
  text.each_char.with_index do |char, index|
    return false unless char == text[second]
    second -= 1
    break if second <= index
  end
  true
end

def sum_squares(squares)
  return false unless squares.respond_to? :each
  total = 0
  squares.each do |square|
    total += square**2
  end
  total
end

puts sum_squares([1, 2, 3])
puts palindrome? 'HolaaloH'
puts palindrome? 'Logan'
