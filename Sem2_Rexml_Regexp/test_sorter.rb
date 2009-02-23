require 'test/unit'
require 'sorter.rb'

class TestSorter < Test::Unit::TestCase
  def setup
    @football = Sorter.new('football.txt')
    @weather = Sorter.new('weather.txt')
  end
  
  def teardown
    @football = nil
    @weather = nil
  end
  
  #Begin tests
  def test_instance_of
    assert_instance_of(Sorter, @football)
    assert_instance_of(Sorter, @weather)
  end
  
  def test_parsers
    assert_kind_of(Array, @football.values)
    assert_kind_of(Array, @weather.values)
    
    assert_equal(false, @football.keys.empty?)
    assert_equal(false, @weather.values.empty?)
    
    
    @football.values.each do |i| 
      assert_kind_of(Fixnum, i )
      assert( i => 0)
    end 
       
    @weather.values.each  do |i| 
      assert_kind_of(Fixnum, i )
      assert( i => 0) 
    end
    
    @football.keys.each do |i| 
      assert_kind_of(String, i )
      assert_match(/^[A-Z][a-z_]+/, i)   
    end
      
    @weather.keys.each  do |i| 
      assert_kind_of(String, i ) # We never do a .to_i on the elements
      assert_match(/\d+/, i)
    end 
    
  end
  
  def test_hash_maker
    assert_kind_of(Hash, @football.list_hash)
    assert_kind_of(Hash, @weather.list_hash)
    
     @football.list_hash.each do |i| 
           assert_kind_of(String, i[0] )
           assert_kind_of(Fixnum, i[1] )
           
      end
          
      @weather.list_hash.each do |i| 
                assert_kind_of(String, i[0] )
                assert_kind_of(Fixnum, i[1] )
      end
      
	assert_equal(@football.list_hash.values.sort, @football.values.sort)
        assert_equal(@weather.list_hash.values.sort, @weather.values.sort)
       
        assert_equal(@football.list_hash.keys.sort, @football.keys.sort)
        assert_equal(@weather.list_hash.keys.sort, @weather.keys.sort)
      
  end
  
end