load 'extensions.rb'
require 'test/unit'

class TestAccessor < Test::Unit::TestCase
  #Setup objects
  def setup
    @a1 = %w(1 2 3)
    @a2 = %w(2 3 4)
    @a3 = [{:v => 1, :c => "a", }, {:c => "b", :v => 2}]
    @a4 = [{:c => "b", :v => 2}, {:c => "c", :v => 3}]
  end
  
  #Remove objects
  def teardown
    @a1 = nil
    @a2 = nil
    @a3 = nil
    @a4 = nil
  end
     
  #Begin with tests
  
  def test_shuffle
    assert_kind_of(Array, @a1.shuffle)
    assert_equal(@a1.length, @a1.shuffle.length)
    assert_equal(@a1.sort, @a1.shuffle.sort)
    #assert_not_equal(@a1, @a1.shuffle) #Not always true
  end
    
  def test_intersect
    assert_kind_of(Array, @a1.intersect(@a2))
    assert_equal((@a1 & @a2), @a1.intersect(@a2))
    assert_equal(%w(2 3), @a2.intersect(@a1))
    assert_equal([], @a1.intersect(@a3))
    assert_equal([{:c => "b", :v => 2}], @a3.intersect(@a4))
  end
      
  def test_union
      assert_kind_of(Array, @a1.union(@a2))
      assert_equal((@a1 + @a2), @a1.union(@a2))
      assert_equal(%w(2 3 4 1 2 3), @a2.union(@a1))     
  end
  
  def test_fib
    assert_kind_of(Fixnum, 1.fib)
    assert_kind_of(Fixnum, 3.fib)
    assert_equal(1, 1.fib)
    assert_equal(6765, 20.fib)
  end
  
end