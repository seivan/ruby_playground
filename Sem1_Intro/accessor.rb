# Create a class PersonName, that has the following attributes 
# Name The name of the person. 
# Surname The given name of the person. 
# Fullname “#{surname} #{name}”. Add also a fullname setter function, that splits (String::split) 
# the fullname into surname and name.

class PersonName
  attr_accessor :surname, :name
  
  def initialize(full_name)
      puts "Please your surname and name" unless full_name.kind_of?(String)
      full_name_setter(full_name) if full_name.kind_of?(String)
  end

    def full_name_setter(full_name)
        @surname_and_name = full_name.split(' ') 
        @surname = @surname_and_name[0]
        @name = @surname_and_name[1]
        @fullname = "#{surname} #{name}"
    end
end


# Create a class Person, that has the following attributes 
# Age The person’s age (in years). 
# Birthdate The person’s birthdate. 
# Name A PersonName object. 
# The person’s constructor should allow to pass in name, surname and age. All optionally.  
# The person’s age and birth date should always be consistent. That means if I set the person’s 
# birth date, his age should change. And if I set a person’s age, his birth date should change

class Person < PersonName
  attr_reader :age, :birthdate
  
    def initialize(name = " ", surname = " ", age = 0)
         @Person = PersonName.new("#{surname} #{name}") 
         @name = @Person.name
         @surname = @Person.surname
         @birthdate = Time.now.year - age if age > 0 and age.kind_of?(Fixnum)
         @age = Time.now.year - @birthdate if @birthdate != nil
       end
    
    def age=(years)
      @age = years
      @birthdate = Time.now.year - @age
    end
    
    def birthdate=(year)
      @birthdate = year
      @age = Time.now.year - @birthdate
    end
    
end
