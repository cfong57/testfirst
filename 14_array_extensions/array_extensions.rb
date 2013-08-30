##
#can do this without cheating if needed...
#
#empty? = true if(length == 0)
#each = length.times do |i| total += at(i) end
#collect = length.times do |i| [] << self[i] * self[i] end
#
#collect! = length.times do |i| self[i] *= self[i] end

class Array
  def sum
    total = 0
    each {|i| total += i } unless empty?
    return total
  end

  def square
    empty? ? [] : collect {|i| i *= i}
  end

  def square!
    empty? ? [] : collect! {|i| i *= i}
  end
end