require 'minitest/autorun'
require_relative 'go'

class GoTest < MiniTest::Unit::TestCase
  def test_go_raise_if_block_is_not_given
    assert_raises(Go::MissingBlockError) { go }
  end

  def test_go_executes_block
    a = nil

    routine = go { a = 'hola' }

    assert_equal 'hola', routine.join.value
  end

  def test_go_executes_block_in_a_thread
    assert_instance_of Thread, go {}
  end
end

class ChannelTest < MiniTest::Unit::TestCase
  def test_new_channel_size_is_zero
    assert_equal 0, channel.size
  end

  def test_can_push_to_channel
    c = channel
    c << 1

    assert_equal 1, c.size
  end

  def test_can_consume
    c = channel
    c << 1

    assert_equal 1, c.pop
  end
end
