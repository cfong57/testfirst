#Time.stub(:now) { eleven_am }
#when Time.now is called, return eleven_am instead

def measure(howmany = 1, &block)
  x = Time::now
  howmany.times{yield}
  return (Time::now - x) / howmany
end