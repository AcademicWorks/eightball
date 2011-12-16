# encoding: UTF-8

require 'helper'

class TestEightball < Test::Unit::TestCase
  should "return utf-8 when utf-8 is called" do
    assert_equal "ウabcé", "ウabcé".encode("utf-8")
  end
  
end
