def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def sum(numbers)
  total = 0
  numbers.each {|i| total += i }
  return total
end

def multiply(*numbers)
  numbers.inject {|a, b| a * b }
end 

def power(a, b)
  total = 1
  b.times {total *= a }
  return total
end

def factorial(x)
  x > 0 ? total = 1 : total = 0
  x.downto(1) {|i| total *= i }
  return total
end