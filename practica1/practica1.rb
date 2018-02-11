# This class is a decorator circuit breaker
class CircuitBreaker
  attr_accessor :max_failures

  def initialize(resource)
    @resource = resource
    @max_failures = 3
    reset
  end

  def reset
    @failure_count = 0
  end

  def state
    @failure_count >= @max_failures ? :open : :closed
  end

  def call
    case state
    when :closed
      do_call
    when :open
      puts 'circui breaker open. calls aren´t made it'
    end
  end

  def do_call
    @resource.call
    puts 'call made it with success'
  rescue StandardError
    @failure_count += 1
    puts 'some error ocurred'
  end
end

# This class divide 1 by the number given
class Divide
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def call
    1 / value
  rescue StandardError
    raise StandardError
  end
end

def ceasars_crypt(string)
  string.gsub!(/[^a-zA-Z]/, '')
  string = string.upcase
  string.each_char.with_index do |char, index|
    current = char.ord + 13
    string[index] = (current > 90 ? 64 + (current - 90) : current).chr
  end
  string
end

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
puts palindrome? 'abcdcba'
puts palindrome? 'abcddcba'
puts palindrome? 'nope'
puts ceasars_crypt 'hola mundo!!'
puts ceasars_crypt ceasars_crypt('hola mundo!!')
rs = Divide.new 2
cir = CircuitBreaker.new rs
cir.call
rs.value = 0
cir.call
cir.call
cir.call
cir.call
cir.call
cir.call
cir.call
cir.call
cir.reset
rs.value = 2
cir.call
