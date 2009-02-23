load 'accessor.rb'
require 'test/unit'

class TestAccessor < Test::Unit::TestCase
  #Setup objects
  def setup
    @names = PersonName.new("Heidari Seivan")
    @person = Person.new("Heidari", "Seivan", 20)
    @incomplete_person = Person.new()
  end
  
  #Remove objects
  def teardown
    @names = nil
    @person = nil
    @incomplete_person = nil
  end
  
  #Helper functions
  def change_names(object)
    object.name = "Markus"
    object.surname = "Vestin"  
  end
  
  def change_fullname(object)
    object.full_name_setter("surname firstname")
  end
  
  def change_age(object)
    object.age = 17
  end
  
  def change_birthdate(object)
    object.birthdate = 2008
  end
  
  #Begin with tests
  def test_names
    assert_instance_of(PersonName, @names)
    assert_equal("Seivan", @names.name)
    assert_equal("Heidari", @names.surname)
    change_names(@names)
    assert_equal("Markus", @names.name)
    assert_equal("Vestin", @names.surname)
    change_fullname(@names)
    assert_equal("firstname", @names.name)
    assert_equal("surname", @names.surname)
  end
  
  def test_age_and_birthdate
    assert_instance_of(Person, @person)
    assert_equal(20, @person.age)
    assert_equal(1989, @person.birthdate)
    
    change_age(@person)
    assert_equal(17, @person.age)
    assert_equal(1992, @person.birthdate)
    
    change_birthdate(@person)
    assert_equal(1, @person.age)
    assert_equal(2008, @person.birthdate)
  end
  
  
  def test_optional_parameters
    assert_instance_of(Person, @incomplete_person)
    assert_nil(@incomplete_person.name)
    assert_nil(@incomplete_person.surname)
    assert_nil(@incomplete_person.age)
    assert_nil(@incomplete_person.birthdate)
    
    change_names(@incomplete_person)
    assert_equal("Markus", @incomplete_person.name)
    assert_equal("Vestin", @incomplete_person.surname)
    
    change_fullname(@incomplete_person)
    assert_equal("firstname", @incomplete_person.name)
    assert_equal("surname", @incomplete_person.surname)
    
    change_age(@incomplete_person)
    assert_equal(17, @incomplete_person.age)
    assert_equal(1992, @incomplete_person.birthdate)
    
    change_birthdate(@incomplete_person)
    assert_equal(1, @incomplete_person.age)
    assert_equal(2008, @incomplete_person.birthdate)    
  end
    
end
