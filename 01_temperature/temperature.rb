def ftoc(far)
  (far.to_f - 32.0) * (5.0 / 9.0) 
end

def ctof(cel)
  (cel.to_f * (9.0 / 5.0)) + 32.0
end