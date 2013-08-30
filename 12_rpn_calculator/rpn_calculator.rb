class RPNCalculator
  attr_accessor :stack
  def initialize
    @stack = []
  end

  @@symbols = {"+" => :plus, "-" => :minus, "*" => :times, "/" => :divide }

  def push(thing)
    stack.push(thing)
  end

  def plus
    stack.empty? ? raise("calculator is empty") : stack.push(stack.pop + stack.pop) 
  end

  #cheating - not really subtraction, but addition of the inverse
  def minus
    stack.empty? ? raise("calculator is empty") : stack.push(-(stack.pop) + stack.pop)
  end

  def times
    stack.empty? ? raise("calculator is empty") : stack.push((stack.pop * stack.pop).to_f)
  end
  
  #cheating - not really division, but multiplication of the inverse
  #todo: raise a different error for divide by zero
  def divide
    stack.empty? ? raise("calculator is empty") : stack.push(((1.0/(stack.pop)) * stack.pop).to_f)
  end

  #last value in the stack is always the current result
  def value
    stack.empty? ? raise("calculator is empty") : stack.last
  end

  def tokens(string)
    tok = string.split(" ")
    tok.collect! {|t| @@symbols.keys.include?(t) ? t.to_sym : t.to_i }
  end

  #safety check since using Object#send
  def method_missing(methId)
    raise("invalid operation '#{methId.id2name}'")
  end

  def evaluate(string)
    tok = string.split(" ")
    tok.collect! {|t| @@symbols.keys.include?(t) ? t = @@symbols[t] : t.to_i }
    #this is redundant, but the rspec case for #tokens wants them returned
    #as symbols :+ :- :* :/
    #not :plus :minus :times :divide

    tok.each {|t| t.is_a?(Fixnum) ? push(t) : send(t) }
    return value
  end
end