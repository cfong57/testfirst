def reverser(&block)
  yield.split(" ").each {|a| a.reverse!}.join(" ")
end

def adder(howmuch = 1, &block)
  yield + howmuch
end

def repeater(n = 1, &block)
  n.times {yield}
end