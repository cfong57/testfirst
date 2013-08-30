class Dictionary
  attr_accessor :entries
  
  #this is cheating, probably, since a keywords array never exists...
  #however, this is much easier for purposes of dynamic updating
  def keywords
    @entries.keys.sort
  end

  def initialize
    @entries = {}
  end

  def include?(word)
    keywords.include?(word)
  end

  def add(info)
    #add a keyword with nil entry if only a keyword was given
    #fancier program would check if keyword exists and then append/overwrite
    info.is_a?(Hash) ? entries[info.keys[0]] = info.values[0] : entries[info] = nil
  end

  def find(prefix)
    results = {}
    #test if entry starts with prefix
    keywords.each {|i| results[i] = entries[i] if(i =~ /\A#{prefix}/) }
    return results
  end

  def printable
    string = ""
    keywords.each {|key| string << "[#{key}] \"#{entries[key]}\"\n" }
    return string.chop! #get rid of the last \n
  end
end