class A
  #attr_accessor :val
  def initialize(in_val)
    @val=in_val
  end

  def set(in_val)
    @val = in_val
  end

#G�r funktionen protected, sedan implementera en ropfunktion, samtidigt som vi tog bort attr_accessor, vill man fortarande ha en s�dan funktion kan man implementera en getter (returna) och en setter (void, �ndra val)

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
#Till�ter oss att ropa och �ndra variabeln med objektet.
# T.ex a = A.new(5); a.val -> 5. a.val=20; a.val -> 20
# tar vi bort accessorn, sa kommer det inte att funka.

#B) Vi skuggar funktionen a.square med en egen funktion.
#G�r vi ett nytt objekt s� funkar den som den ska, dvs
#k = A.new(20) a.square -> 400.
#Skuggningen effekterar endast a.class -> A

#C Bra om man vill overrida/skugga objektfunktionen utan att extenda klassen

#D Kolla koden ovan, tog bort attr_accessor, gjorde square protected, gjorde en class som anropar square. 
#G�r �ven att g�ra getter/setter f�r val om man s� vill.
