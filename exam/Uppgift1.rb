class A
  #attr_accessor :val
  def initialize(in_val)
    @val=in_val
  end

  def set(in_val)
    @val = in_val
  end

#Gör funktionen protected, sedan implementera en ropfunktion, samtidigt som vi tog bort attr_accessor, vill man fortarande ha en sådan funktion kan man implementera en getter (returna) och en setter (void, ändra val)

  def caller()
    return square
  end

 protected
  def square
   @val*@val
    end
end


 puts "SO SOLLY!"
  b = A.new(20)
  b.square


    






#A) Vi har en getter och setter i form av attr_accessor :val
#Tillåter oss att ropa och ändra variabeln med objektet.
# T.ex a = A.new(5); a.val -> 5. a.val=20; a.val -> 20
# tar vi bort accessorn, sa kommer det inte att funka.

#B) Vi skuggar funktionen a.square med en egen funktion.
#Gör vi ett nytt objekt så funkar den som den ska, dvs
#k = A.new(20) a.square -> 400.
#Skuggningen effekterar endast a.class -> A

#C Bra om man vill overrida/skugga objektfunktionen utan att extenda klassen

#D Kolla koden ovan, tog bort attr_accessor, gjorde square protected, gjorde en class som anropar square. 
#Går även att göra getter/setter för val om man så vill.
