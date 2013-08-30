class XmlDocument
  attr_accessor :true_indent
  attr_accessor :nest
  def initialize(flag = false)
    @true_indent = flag
    @nest = 0
    ## 
    #how deeply nested are we?
    #0<hello>
    #1  <goodbye>
    #2    <come_back/>
    #1  </goodbye>
    #0</hello>
  end
  
  def generate_tag(tagname, attributes = nil, extra = nil)
    if(true_indent)
      newline = "\n"
      indent = "  " * @nest
      #"  " * 0 = ""
    else
      newline = ""
      indent = ""
    end
    if(extra.nil?)
      tag = "#{indent}<#{tagname}#{attributes.to_s}/>#{newline}"
      #<hello name='dolly'/>
      #or just <hello/> since nil.to_s == ""
    else
      tag = "#{indent}<#{tagname}#{attributes.to_s}>" +
      "#{newline}#{extra}#{indent}</#{tagname}>#{newline}"
      #if a block was given
      #<hello><goodbye/></hello>
      #legacy attributes.to_s in case attributes also given (no such test case yet)
    end
  end
  
  def method_missing(methId, attributes = nil, &block)
    if(attributes.nil?)
      att = nil
    else 
      att =  " #{attributes.keys[0].to_s}='#{attributes.values[0].to_s}'"
      # name='dolly'
      #this is the only ugly part of the code left, not sure how else to parse nicely
    end

    if(block_given?)
      @nest += 1
      #entering an iteration: nest +1
      result = yield
      @nest -= 1
      #leaving an iteration: nest -1
      generate_tag(methId.id2name, att, result)
    else
      generate_tag(methId.id2name, att)
    end
  end
end