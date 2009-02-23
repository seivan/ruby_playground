load 'iteration.rb'

require 'test/unit'
class TestIteration < Test::Unit::TestCase
  def setup
    @r = Repeat.new(3)
    @words = %w(first second third IamTheAlphaAndTheOmega fourth fifth sixth)
  end
  
  def teardown
    @r = nil
    @words = nil
  end
  
  #Begin tests
  def test_class
    assert_instance_of(Repeat, @r)
    assert_kind_of(Repeat, @r)
  end
  
  def test_each
     assert_instance_of(String,"Block called\n", @r.each { puts "666" })
  end
  
  def test_n_times
    assert_kind_of(Fixnum, Repeat.n_times(3))
  end
  
  def test_factorial
    assert_equal(2432902008176640000, factorial())
    assert_equal(6, factorial(3))
    assert_kind_of(String, factorial("TEST"))
  end
  
  def test_longeststring
    assert_equal("IamTheAlphaAndTheOmega", maximum(@words))
    assert_equal(@words.max {|y, x| y.size <=> x.size}, maximum(@words))
  end
  
end