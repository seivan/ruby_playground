class Array
  def shuffle
    self.sort_by { rand }
  end  
  def intersect(other_array)
    (self & other_array).uniq
  end
  def union(other_array)
    (self + other_array)
  end
end

class Integer
    def fib
        if self < 2
            return self
        else
            return (self-1).fib + (self-2).fib
        end
    end
end
