##
#could MAYBE combine these into one single to_pig method, for the String class
#but it would be messy/repetitive and many more checks and special cases exist
#example: email addresses, phone numbers (digits in general), URLs...

#method that does the actual pigging
def pig(word, howmany = 0)
  chars = word.split(//)
  lastletter_index = word.rindex(/\w/)
  puncs = {}
  
  #grab punctuation, store info in hash
  chars.each_index { |x| puncs[x] = chars.at(x) if chars.at(x) =~ /\W/ }

  #delete punctuation so we only deal with letters, does nothing if no punc  
  chars.delete_if {|x| puncs.values.include?(x)} 

  #not the most elegant for dealing with starts-with-vowel words, but more modular this way
  #skip this swapping stuff if it's a vowel for first letter
  if(howmany > 0) 
    first = chars.slice!(0, howmany) #grab the first n chars, delete grabbed

    if(first[0] == first[0].upcase) #word was capitalized, swap order
      chars[0].upcase!
      first[0].downcase!
    end

    chars += first
  end

  #add back punctuation if it existed, does nothing if no punc
  puncs.keys.each { |key| chars.insert(key, puncs[key]) }
  
  #length == 1 means we got a single vowel like "I"; different rule
  chars.length == 1 ? chars << "way" : chars.insert(lastletter_index + 1, "ay")  
  return chars.join("")
end

#method that tells pig what it's processing
def translate(sentence)
  words = sentence.split(" ")
  words.collect! do |a|
    if(a =~ /\w\.\.\.\w/) #matching e.g "yes...no"
      morewords = a.split("...")
      ##
      #alternative: allows for recursion, but loses accuracy since "a...b" becomes "a ... b"
      #probably some non-messy way to make it work, and be less redundant too
      #
      #morewords.insert(1, "...")
      #translate(morewords.join(" "))
      pig(morewords[0], 1) + "..." + pig(morewords[1], 1)
    elsif(a =~ /\w\W\w/ and !(a =~ /'/)) #matching e.g. "steins;gate", "ninety-nine", but not "it's"
      nonletter = a.scan(/\W/)[0]
      morewords = a.split(/\W/)
      #morewords.insert(1, nonletter)
      #translate(morewords.join(" "))
      pig(morewords[0], 1) + nonletter + pig(morewords[1], 1)
    elsif(a[0..1].match(/qu/)) #quiet = ietquay
      pig(a, 2)
    elsif(a[0..2].match(/sch|.qu/)) #school = oolschay, square = aresquay
      pig(a, 3)
    else
      x = a.index(/[AaEeIiOoUu]/) #starts with other consonant(s) or a vowel; find the first vowel
      if(!(x.nil?)) #found at least one vowel
        pig(a, x) 
      else #x is nil, no vowels found
        a.index(/[[:alpha:]]/) ? pig(a, 1) : a #if it contains letters, attempt to process; otherwise, do nothing
      end
    end
  end
  return words.join(" ")
end