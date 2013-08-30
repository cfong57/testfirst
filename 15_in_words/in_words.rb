##
#47 test cases, 117 iterations
#about 56% less efficient than the proposed solution on github (in_words.rb)
#which only has 75 iterations
#
#this is an UGLY brute force hack that could use some serious refactoring
#function over form though...
#
#***for purposes of easy testing I extend Intenger, not Fixnum***
#
#I see that the "proper" way to do this is to write the code as a module
#and then include it to both Fixnum and Bignum, which is probably better
#in some way, but not sure right now with my limited knowledge

class Integer
  #class variables since they don't need to be created over and over
  #and also no real reason to call on them outside of Integer
  @@ones = {1 => " one ", 2 => " two ", 3 => " three ", 4 => " four ", 5 => " five ",
  6 => "six", 7 => "seven ", 8 => "eight ", 9 => "nine "}
  
  @@teens = {11 => " eleven ", 12 => " twelve ", 13 => " thirteen ", 14 => " fourteen ",
  15 => " fifteen ", 16 => " sixteen ", 17 => " seventeen ", 18 => " eighteen ",
  19 => " nineteen "}

  @@tens = {1 => " ten ", 2 => " twenty ", 3 => " thirty ", 4 => " forty ", 5 => " fifty ",
  6 => " sixty ", 7 =>" seventy ", 8 => " eighty ", 9 => " ninety "}

  @@bigs = {4 => " trillion ", 3 => " billion ", 2 => " million ", 1 => " thousand "}

  @@iterations = 0

  def in_words(word_flag = nil)
    @@iterations += 1
    p "its: #{@@iterations}"
    #the one super special case to give up before starting
    if(zero?)
      if(word_flag.nil?)
        return "zero"
      else
        return ""
      end
    end

    numstring = ""
    number = self.abs
    numstring += "negative " if(number != self)

    pre = self.to_s
    if(pre.length > 6) #past 999999
      pre.insert(-4, "_")
      pre.insert(-8, "_")
      pre.insert(-12, "_") if(pre[-12])
      pre.insert(-16, "_") if(pre[-16])
      pre.insert(-20, "_") if(pre[-20])

      pieces = pre.split("_")
      pieces.collect! {|i| i = i.to_i.in_words(:f)}
      pieces.reverse!
      pieces.each_index {|i| pieces[i] += @@bigs[i] unless (i == 0 or pieces[i] == "")}
      pieces.reverse!
      numstring = pieces.join("")

      #why bother concatenating correctly when you have formatting methods
      numstring.gsub!(/\s\s/, " ")
      numstring.strip!
      return numstring #leave early
    end

    if(number < 10)
      numstring += @@ones[number]
    elsif(number.between?(11, 19))
      numstring += @@teens[number]
    elsif(number.between?(10, 99))
      numstring += @@tens[number / 10]
      ones = number.to_s.split(//).last.to_i #cheating
      numstring += ones.in_words(:f)
    elsif(number.between?(100, 999))
      hunds = number / 100
      numstring += @@ones[hunds] + " hundred "
      remainder = number - (hunds * 100)
      numstring += remainder.in_words(:f)
    else
      h_sub = 0
      h_str = ""
      last_str = ""
      thousands = 0
      thousands = number / 1000 #0..999
      h_sub = thousands * 1000
      h_str = thousands.in_words(:f)
      h_str += " thousand " if(h_str != "")
      remainder = number - h_sub
      last_str = remainder.in_words(:f)
      numstring += (h_str + last_str)
    end

    #why bother concatenating correctly when you have formatting methods
    numstring.gsub!(/\s\s/, " ")
    numstring.strip!
    return numstring
  end
end