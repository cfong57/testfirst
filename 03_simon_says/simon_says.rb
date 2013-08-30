def echo(text)
  text
end

def shout(text)
  text.upcase!
end

def repeat(text, times = 2)
  str = ""
  times.times {str += "#{text} "}
  return str.chop!
end

def start_of_word(word, howmany = 1)
  word.split(//)[0..howmany - 1].join("")
end

def first_word(sentence)
  sentence.split(" ")[0]
end

def titleize(sentence)
  littles = ["at", "under", "over", "near", "upon", "by", "of", "a", "an", "in", "the", "and", "or", "but"]
  #it's more complicated than that, but for the purposes of this exercise it's fine
  words = sentence.split(" ")
  words.each {|a| a.capitalize! if(a == words.first or !(littles.include?(a))) }
  return words.join(" ")
end