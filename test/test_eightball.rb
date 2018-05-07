# encoding: utf-8

require './helper.rb'

class TestEightball < Test::Unit::TestCase
  should 'return utf-8 when utf-8 is called' do
    assert_equal "ウabcé", "ウabcé".encode('utf-8')
  end

  should 'remove invalid UTF-8 byte sequences' do
    string = File.read('./files/test1')
    string = string.eightball
    assert !string.empty?
    assert string.valid_encoding?
    assert string.encoding == Encoding::UTF_8
  end

  should 'remove carriage return if exists' do
    test_string = "foobarbarbaz\r\n"
    new_string = "foobarbarbaz\n"
    assert_equal new_string, test_string.eightball
    assert !new_string.include?("\r")
    puts new_string.eightball
  end

  should 'remove carriage return in test' do
    string = File.read('./files/test_with_returns1.csv')
    string = string.eightball
    assert !string.empty?
    assert string.valid_encoding?
    assert string.encoding == Encoding::UTF_8
  end
end
