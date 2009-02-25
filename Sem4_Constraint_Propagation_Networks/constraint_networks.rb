#!/usr/bin/env ruby

# In this assignment you will learn how to implement a constraint
# network. We begin with a simple example of a constraint network that
# uses digital gates. This example also illustrates the use of class
# inheritance, since both classes AndGate and OrGate inherit from the
# BinaryGate class for initialization.

require 'logger'

module PrettyPrint

  # To make printouts of connector objects easier, we define the
  # inspect method so that it returns the value of to_s. This method
  # is used by Ruby when we display objects in irb. By defining this
  # method in a module, we can include it in several classes that are
  # not related by inheritance.
  def inspect
    "#<#{self.class}: #{to_s}>"
  end

end

class BinaryConstraint

  def initialize(input1,input2,output)
    @input1=input1
    @input1.add_constraint(self)
    @input2=input2
    @input2.add_constraint(self)
    @output=output
    new_value()
  end

  
end

class AndGate < BinaryConstraint
  
  def new_value
    sleep 0.2
    @output.value=(@input1.value and @input2.value)
  end
  
end


class OrGate < BinaryConstraint
    
  def new_value
    sleep 0.2
    @output.value=(@input1.value or @input2.value)
  end
  
end

class NotGate
  
  def initialize(input,output)
    @input=input
    @input.add_constraint(self)
    @output=output
    new_value
  end
  
  def new_value
    sleep 0.2
    @output.value=(not @input.value)
  end
  
end

class Wire
  
  attr_accessor :name
  attr_reader :value
  def initialize(name,value=false)
    @name=name
    @value=value
    @constraints=[]
    @logger=Logger.new(STDOUT)
  end
  
  def log_level=(level)
    @logger.level=level
  end
  
  def add_constraint(gate)
    @constraints << gate
  end
  
  def value=(value)
    @logger.debug("#{name} = #{value}")
    @value=value
    @constraints.each { |c| c.new_value }
  end
    
  
end

# When you use test_constraints, it will prompt you for input before
# proceeding. That way you can analyze what happens in the code before
# you go on. You need only press 'enter' to continue.

def test_constraints
  a=Wire.new('a')
  b=Wire.new('b')
  c=Wire.new('c')
  # If you want to see when c changes value, set the log_level of c to
  # Logger::DEBUG

  c.log_level=Logger::DEBUG
  puts "Testing the AND gate"
  andGate=AndGate.new a,b,c
  a.value=true
  gets
  b.value=true
  gets
  a.value=false
  gets

  a=Wire.new('a')
  b=Wire.new('b')
  c=Wire.new('c')
  puts "Testing the OR gate"
  orGate=OrGate.new a,b,c
  a.value=false
  gets  
  b.value=false
  gets
end

# Make sure you understand how the binary gate example works before
# you proceed with the assignment: The Fahrenheit2celsius converter

########################################
# 1. Fahrenheit -> Celsius converter

# In the example above, our constraint network was unidirectional:
# That is, changes could not propagate from the output wire to the
# input wires. However, to model equation systems such as the
# correlation betwen the two units of measurement Celsius and
# Fahrenheit, we need to propagate changes from either end to the
# other.

# In this task you will use the connector class to connect via
# arithmetic constraints such as the Adder and Multiplier below

# All constraints have the Arith class as their base class. Currently,
# we only have two constraints defined: Adder and Multiplier.

class ArithmeticConstraint

  # We include functionality from the module PrettyPrint to make the
  # textual representation of objects easier to read.
  include PrettyPrint

  # attr_accessor and attr_reader make instance variables available
  # through methods with the same name as the instance variables
  # without the '@' sign. For example, 'attr_accessor :a' makes the
  # instance variable '@a' available inside the object methods of
  # ArithmeticConstraint through the use of the instance method 'a'

  attr_accessor :a,:b,:out
  attr_reader :logger,:op,:inverse_op
  def initialize(a,b,out)
    @logger=Logger.new(STDOUT)
    @a,@b,@out=[a,b,out]
    [a,b,out].each {|x| @logger.debug("adding_constraint: #{self} to #{x}"); x.add_constraint(self)}
  end
  
  def to_s
    "#{a} #{op} #{b} == #{out}"
  end
  
  def new_value(connector)
    @logger.debug("New Value: #{connector}")
    if [a,b,out].include?(connector) and a.has_value? and b.has_value? and 
        (not out.has_value?) then 
      # Inputs changed, so update output to be the sum of the inputs
      # "send" means that we send a message, op in this case, to an
      # object.
      @logger.debug(" #{out} has no value ")
      val=a.value.send(op,b.value)
      @logger.debug("val: #{val}")
      logger.debug("#{self} : #{out} updated")
      out.assign(val,self)
      self
    elsif [a,b,out].include?(connector) and (not a.has_value?) and b.has_value? and 
          out.has_value? then
      @logger.debug(" #{a} has no value")
      val=out.value.send(inverse_op,b.value)
      @logger.debug("val: #{val}")
      logger.debug("#{self} : #{a} updated")
      a.assign(val,self)
      self
    elsif [a,b,out].include?(connector) and a.has_value? and (not b.has_value?) and 
          out.has_value? then
      @logger.debug(" #{b} has no value")
      val=out.value.send(inverse_op,a.value)
      @logger.debug("val: #{val}")
      @logger.debug("#{self} : #{b} updated")
      b.assign(val,self)
      self        
    end
    self
  end
  
  # A connector lost its value, so propagate this information to all
  # others
  def lost_value(connector)
    @logger.debug("lost_value connector #{connector}")
    ([a,b,out]-[connector]).each { |connector| @logger.debug("#{self} added to #{connector}"); connector.forget_value(self) }
  end
  
end

class Adder < ArithmeticConstraint
  
  def initialize(*args)
    super(*args)
    @op,@inverse_op=[:+,:-]
  end
end

class Multiplier < ArithmeticConstraint

  def initialize(*args)
    super(*args)
    @op,@inverse_op=[:*,:/]
  end
    
end

class ContradictionException < Exception; end


# This is the bidirectional connector which may be part of a constraint network.
class Connector
    
  # We include functionality from the module PrettyPrint to make the
  # textual representation of objects easier to read.
  include PrettyPrint

  attr_accessor :name,:value
  def initialize(name,value=false)
    @logger=Logger.new(STDOUT)
    @logger.debug("Creating connector #{name} #{value}")
    self.name=name
    @logger.debug("self: #{self} , self.name #{self.name}")
    @has_value=value
    @logger.debug("#{@has_value}")
    @value=value
    @informant=false
    @constraints=[]
  end

  def add_constraint(c)
    @constraints << c
    @logger.debug("add_constraint: #{@constraints}")
  end
    
  # Values may not be set if the connector already has a value, unless
  # the old value is retracted. Why?
  def forget_value(retractor)
    @logger.debug("informant: #{@informant}")
    @logger.debug("retractor: #{retractor}")
    if @informant==retractor then
     @logger.debug("retractor: #{self} is #{retractor}")
      @has_value=false
      @value=false
      @informant=false
      @logger.debug("#{self} lost value")
      @logger.debug("#{@constraints-[retractor]} ")
      other_constraints=(@constraints-[retractor])
      @logger.debug("#{other_constraints} ")
      @logger.debug("Notifying #{other_constraints}") unless other_constraints == []
      other_constraints.each { |c| @logger.debug("losing value: #{c}"); c.lost_value(self) }
      "ok"
    else
      @logger.debug("#{self} ignored request")
    end
  end

  def has_value?
    @has_value
  end
  
  # The user may use this procedure to set values
  def user_assign(value)
    forget_value("user")
    assign(value,"user")
  end
  
  def assign(v,setter)
      if not has_value? then
        @logger.debug("#{name} got new value: #{v}")
        @value=v
        @logger.debug("value:#{v} and setter: #{setter}")
        @has_value=true
        @informant=setter
        @logger.debug("informant: #{@informant}")
        (@constraints-[setter]).each { |c| @logger.debug("each constraint: #{c} with #{self}");  c.new_value(self) }
        "ok"
      else
        if value != v then
          raise ContradictionException.new("#{name} already has value #{value}.\nCannot assign #{name} to #{v}")
      end
    end
  end
  
  def to_s
    name
  end

  
end

class ConstantConnector < Connector
  
  def initialize(name,value)
    super(name,value)
    if not has_value?
      @logger.warn "Constant #{name} has no value!!"
    end
  end
  
  def value=(val)
    raise ContradictionException.new("Cannot assign a constant a value")
  end
end
  
# This is a test of the constraint network

# class Fahrenheit_and_Celsius
#   attr_accessor :c, :f
#   def initialize
#     #Get 9/5 -> nine_div_five
#     five = Connector.new("5")
#     nine_div_five = Connector.new("9/5")
#     nine = Connector.new("9")
#     Multiplier.new(five,nine_div_five,nine)
#     nine.user_assign 9.to_f
#     five.user_assign 5
# 
#     # Get c * (9/5)
#        @c = Connector.new("c")
#        c_times_nine_div_five = Connector.new("c*9/5")
# 
#          Multiplier.new(@c, nine_div_five, c_times_nine_div_five)
# 
#          @c.user_assign 37.to_f
#          puts @c.value
#          puts nine_div_five.value
#          puts c_times_nine_div_five.value
# 
# 
#       #Get F <- c - 32
#       c_plus_32 = Connector.new("c+32")
#       @f = Connector.new("f")
#       Adder.new(c_times_nine_div_five, c_plus_32, @f)
# 
#       c_plus_32.user_assign 32
#       puts c_times_nine_div_five
#       puts c_plus_32.value
#       puts @f.value
# 
#       @c.forget_value "user"
#       @f.user_assign 120
#       puts @c.value
#       return [@c, @f]
#   end
# end
# 
# Fahrenheit_and_Celsius.new
# 
# puts 
    
def test_adder
  #Get 9/5 -> nine_div_five
  five = Connector.new("5")
  nine_div_five = Connector.new("9/5")
  nine = Connector.new("9")
  Multiplier.new(five,nine_div_five,nine)
  nine.user_assign 9.to_f
  five.user_assign 5



  
  # Get c * (9/5)
     c = Connector.new("c")
     c_times_nine_div_five = Connector.new("c*9/5")
       
       Multiplier.new(c, nine_div_five, c_times_nine_div_five)
       
       c.user_assign 100.to_f
       puts c.value
       puts nine_div_five.value
       puts c_times_nine_div_five.value
     
 
    #Get F <- c - 32
    c_plus_32 = Connector.new("c+32")
    f = Connector.new("f")
    Adder.new(c_times_nine_div_five, c_plus_32, f)
    
    c_plus_32.user_assign 32
    puts c_times_nine_div_five
    puts c_plus_32.value
    puts f.value
    
    c.user_assign 0
    #c.forget_value "user"
    #f.user_assign 120
    puts  f.value
    
  
  
  
end

test_adder

# This is the Fahrenheit->Celsius converter itself. You are supposed
# to write it using the Connector, ConstantConnector, Adder and
# Multiplier classes above, once they work as intended.

# ...

#def fahrenheit2celsius


#end


# This is an example of what it may look like when using the
# fahrenheit2celsius converter:
  

# irb(main):1989:0> c.user_assign 100
# D, [2007-02-08T09:15:01.971437 #521] DEBUG -- : c ignored request
# D, [2007-02-08T09:15:02.057665 #521] DEBUG -- : c got new value: 100
# D, [2007-02-08T09:15:02.058046 #521] DEBUG -- : c * 9 == 9c : 9c updated
# D, [2007-02-08T09:15:02.058209 #521] DEBUG -- : 9c got new value: 900
# D, [2007-02-08T09:15:02.058981 #521] DEBUG -- : f-32 * 5 == 9c : f-32 updated
# D, [2007-02-08T09:15:02.059156 #521] DEBUG -- : f-32 got new value: 180
# D, [2007-02-08T09:15:02.059642 #521] DEBUG -- : f-32 + 32 == f : f updated
# D, [2007-02-08T09:15:02.059792 #521] DEBUG -- : f got new value: 212
# "ok"
# irb(main):1990:0> f.value
# 212
# irb(main):1991:0> c.user_assign 0
# D, [2007-02-08T09:15:19.433621 #521] DEBUG -- : c lost value
# D, [2007-02-08T09:15:19.501880 #521] DEBUG -- : Notifying c * 9 == 9c
# D, [2007-02-08T09:15:19.502214 #521] DEBUG -- : 9 ignored request
# D, [2007-02-08T09:15:19.502380 #521] DEBUG -- : 9c lost value
# D, [2007-02-08T09:15:19.502527 #521] DEBUG -- : Notifying f-32 * 5 == 9c
# D, [2007-02-08T09:15:19.502701 #521] DEBUG -- : f-32 lost value
# D, [2007-02-08T09:15:19.502863 #521] DEBUG -- : Notifying f-32 + 32 == f
# D, [2007-02-08T09:15:19.503031 #521] DEBUG -- : 32 ignored request
# D, [2007-02-08T09:15:19.503427 #521] DEBUG -- : f lost value
# D, [2007-02-08T09:15:19.503570 #521] DEBUG -- : 5 ignored request
# D, [2007-02-08T09:15:19.503699 #521] DEBUG -- : c got new value: 0
# D, [2007-02-08T09:15:19.503860 #521] DEBUG -- : c * 9 == 9c : 9c updated
# D, [2007-02-08T09:15:19.503963 #521] DEBUG -- : 9c got new value: 0
# D, [2007-02-08T09:15:19.504111 #521] DEBUG -- : f-32 * 5 == 9c : f-32 updated
# D, [2007-02-08T09:15:19.504210 #521] DEBUG -- : f-32 got new value: 0
# D, [2007-02-08T09:15:19.504356 #521] DEBUG -- : f-32 + 32 == f : f updated
# D, [2007-02-08T09:15:19.534416 #521] DEBUG -- : f got new value: 32
# "ok"
# irb(main):1992:0> f.value
# 32
# irb(main):1993:0> c.forget_value "user"
# D, [2007-02-08T09:19:56.754866 #521] DEBUG -- : c lost value
# D, [2007-02-08T09:19:56.842475 #521] DEBUG -- : Notifying c * 9 == 9c
# D, [2007-02-08T09:19:56.844665 #521] DEBUG -- : 9 ignored request
# D, [2007-02-08T09:19:56.844855 #521] DEBUG -- : 9c lost value
# D, [2007-02-08T09:19:56.845021 #521] DEBUG -- : Notifying f-32 * 5 == 9c
# D, [2007-02-08T09:19:56.845195 #521] DEBUG -- : f-32 lost value
# D, [2007-02-08T09:19:56.845363 #521] DEBUG -- : Notifying f-32 + 32 == f
# D, [2007-02-08T09:19:56.845539 #521] DEBUG -- : 32 ignored request
# D, [2007-02-08T09:19:56.845664 #521] DEBUG -- : f lost value
# D, [2007-02-08T09:19:56.845790 #521] DEBUG -- : 5 ignored request
# "ok"
# irb(main):1994:0> f.user_assign 100
# D, [2007-02-08T09:20:14.367288 #521] DEBUG -- : f ignored request
# D, [2007-02-08T09:20:14.465708 #521] DEBUG -- : f got new value: 100
# D, [2007-02-08T09:20:14.466057 #521] DEBUG -- : f-32 + 32 == f : f-32 updated
# D, [2007-02-08T09:20:14.466261 #521] DEBUG -- : f-32 got new value: 68
# D, [2007-02-08T09:20:14.466436 #521] DEBUG -- : f-32 * 5 == 9c : 9c updated
# D, [2007-02-08T09:20:14.466547 #521] DEBUG -- : 9c got new value: 340
# D, [2007-02-08T09:20:14.466714 #521] DEBUG -- : c * 9 == 9c : c updated
# D, [2007-02-08T09:20:14.468579 #521] DEBUG -- : c got new value: 37
# "ok"
# irb(main):1995:0> c.value
# 37
