#A) Som jag förstod det så ville du ha dessa namn. Lite osäker om du ville ha de med flera Z:an dock. Men det var så jag antog det

#De sista med små c och k kommer inte med
#C eller K eller s eller z eller ss eller zz.
names = %w(Karlsson, Carlsson, Karlson Karlzzon Carlson Carlzzon Karlzon Carlzon Kyle Carl carlsson karlsson)

#puts "Karlsson".match(/Karlsson/)

reg = /^[K|C]arl[s|z]+on/
names.each do |n| puts n.match(reg) end
