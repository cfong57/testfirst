class Timer
  attr_accessor :seconds
  def initialize
    @seconds = 0
  end
  
  def padded(num)
    num < 10 ? "0#{num}" : num.to_s #not very safe, but lazy
  end

  def time_string()
    seconds_left = padded(@seconds % 60)
    minutes = padded((@seconds / 60) % 60)
    hours = padded(@seconds / 60 / 60)
    return "#{hours}:#{minutes}:#{seconds_left}"
  end
end