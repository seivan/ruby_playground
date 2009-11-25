class Expression
  def initialize(file)
    @code = File.new(file)
    @calculations = []
    @code.each do |x| @calculations << x.gsub(/($\n)/, "") end 
  end

  def creator
    @calculations.each do |x|
      if x != "+"
      instance_eval(x)
      elsif
        puts x
      end
    end
end

 def  method_missing(method, *args)
   puts method
   puts *args
 end
  
end

test = Expression.new("expr.rb")
test.creator
