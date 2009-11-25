
def find_code(file)
  names = File.new(file)
  #Först, allt innan kurskoden[0], sedan kurskoden [1], sedan sluttaggarna[2]
  reg = /^\s+([<a-zA-Z0-9\/=>\"\s]+)>(TDP007)([<a-zA-Z0-9\/=>\"\s]+)/
  storage = []
  #Stoppar i en array ifall vi skulle vilja bygga vidare med olika regexpar
  names.each do |n| storage << reg.match(n) if reg.match(n) != nil  end
  #Ifall vi hade haft flera så hade vi kunnar loppa igenom alla med storage.each do |x| x[1] end
  puts storage[0].captures[1]
end

find_code("tdp007.html")
  
