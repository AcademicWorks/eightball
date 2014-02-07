# encoding: utf-8

require 'helper'

class TestEightball < Test::Unit::TestCase

  should "return utf-8 when utf-8 is called" do
    assert_equal "ウabcé", "ウabcé".encode("utf-8")
  end

  should "remove invalid UTF-8 byte sequences" do
    string = File.read("test/files/test1")
    string = string.eightball
    assert !string.empty?
    assert string.valid_encoding?
    assert string.encoding == Encoding::UTF_8
  end

end
