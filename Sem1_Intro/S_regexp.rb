require 'open-uri.rb'
html = open("http://google.se") { |f| f.read }
x = "<html> <head> <title> Hxello, Rails! </title> </head> <body> <h1>  Hello from Rails! </h1>"

def tag_names(site)
  tags = Array.new
   re = /^<[.+]$>/
   tags =  site.scan(/<(.*?)>/)
   puts tags
 end
 
 tag_names(html)

 re = /^USERNAME:\s[a-zA-Z0-9]+/
# puts "USERNAME: Charlie\nUSERNAME: TEST\n USERNAME:XXX".scan(re)

#Extract Username
word = "USERNAME: Brian"

# n = 2
# n.times do puts 'this is ruby!' end
# 
# def n_times(n) n.times do yield end end
# # # Several chars longer, and a wasted block
#  n_times(2) do puts 'this is bad design!' end
# 
# # Seriously now, dailywtf, juse use #times
# class Repeat
#   def initialize(n); @n = n; end
#   def each
#     @n.times { yield }
#   end
# end
# 
# Repeat.new(2).each { puts 'dailywtf' }
# 
# p (1..20).inject(1) { |i, v| i * v }
# 
# # If generalization is about readability or efficiency, then inject is crazy, 
# # and the range is unnecessary
# def factorial(n)
#   t = 1
#   1.upto(n) { |i| t *= i }
#   t
# end
# 
# p factorial(20)
# 
# strings = %w(a bb ccc dddd eeeee)
# 
# # The minimalist longest_string and shortest_string, in ruby
# p [strings.max, strings.min]