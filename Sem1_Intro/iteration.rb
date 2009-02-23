# Write an iterator function n_times(n) that calls the given block n times. Write an iterator class 
# Repeat that is instantiated with a number and has a method each that takes a block and calls it as 
# often as declared when creating the object. 

class Repeat 
  def initialize(n)
    @n = n
  end  
  def each(&block)
    1.upto(@n) do
      block.call(@n)
    end
  end
  def self.n_times(n)
    0.upto(n) do | i |
      puts "#{i}"
    end
    return n
  end
end


# #Write a one-liner in irb using Range#inject to calculate 20!. 
# #Generalize this into a function.

def factorial(end_number = 20)
    begin
      #One liner!
      return ((1..end_number).inject { |result, x| result * x })
    rescue
      return ("#{end_number} is not an integer!")
    end
end


# Write a function to ﬁnd the longest string in an array of strings.
def maximum(words)
    return (words.max { |word, word_compare| word.length <=> word_compare.length } )
end

# # Write a function find_it that takes an array of strings and a block. The block should take two 
# # parameters and return a boolean value. 
# # The function should allow to implement longest_string, shortest_string, and other functions by 
# # changing the block. 

def find_it(words, &block)
  words.sort(&block).first
end

def longest_string(words)
find_it(words) { |i, f_i| i <=> f_i }
end

