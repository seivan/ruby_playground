load 'regexp.rb'
require 'test/unit'

class TestUsername < Test::Unit::TestCase
  def test_username
    assert(true, extract_username('USERNAME: Brian\nUSERNAME:Bengt'))
    assert_equal(1, extract_username('USERNAME: Brian\nUSERNAME:Bengt').length)
  end
end

class TestRegexp < Test::Unit::TestCase
  
  def test_webpage
    assert(true, parse_website('http://www.google.se/'))
    assert(true, parse_website('local'))
  end
  
end