class Temperature
  attr_accessor :degrees
  attr_accessor :scale
  
  def initialize(hash)
    @degrees = hash.values[0]
    @scale = hash.keys[0]
  end

  #not clear on whether the keys are supposed to be
  #:f or :fahrenheit / :c or :celsius
  def self.from_fahrenheit(deg)
    new(:f => deg)
  end

  def self.from_celsius(deg)
    new(:c => deg)
  end

  def self.ftoc(far)
    (far.to_f - 32.0) * (5.0 / 9.0) 
  end

  def self.ctof(cel)
    (cel.to_f * (9.0 / 5.0)) + 32.0
  end

  def in_celsius
    scale == :c ? @degrees : Temperature.ftoc(@degrees)
  end

  def in_fahrenheit
    scale == :f ? @degrees : Temperature.ctof(@degrees)
  end
end

#how does this improve functionality? don't understand
class Celsius < Temperature
  def initialize(deg)
    @degrees = deg
    @scale = :c
  end
end

class Fahrenheit < Temperature
  def initialize(deg)
    @degrees = deg
    @scale = :f
  end
end