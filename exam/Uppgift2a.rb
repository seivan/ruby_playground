#A) Som jag f�rstod det s� ville du ha dessa namn. Lite os�ker om du ville ha de med flera Z:an dock. Men det var s� jag antog det

#De sista med sm� c och k kommer inte med
#C eller K eller s eller z eller ss eller zz.
names = %w(Karlsson, Carlsson, Karlson Karlzzon Carlson Carlzzon Karlzon Carlzon Kyle Carl carlsson karlsson)

#puts "Karlsson".match(/Karlsson/)

reg = /^[K|C]arl[s|z]+on/
names.each do |n| puts n.match(reg) end
