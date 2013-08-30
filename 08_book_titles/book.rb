#isn't this pretty similar to exercise 03, simon_says#titleize?

class Book
  def initialize
    @title = "The Hitchhiker's Guide to the Galaxy" #don't panic
  end

  def title
    @title
  end

  #normally use attr_accessor :title, but this time doing something special
  #stuff is done *when the var is set*, to scrub the input, not later
  def title=(string)
    littles = ["at", "under", "over", "near", "upon", "by", "of", "a", "an", "in", "the", "and", "or", "but"]
    #it's more complicated than that, but for the purposes of this exercise it's fine
    words = string.split(" ")
    words.each {|a| a.capitalize! if(a == words.first or !(littles.include?(a))) }
    @title = words.join(" ")
  end
end