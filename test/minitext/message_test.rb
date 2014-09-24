require 'test_helper'

module Minitext
  class MessageTest < Minitest::Test

    def setup
      Minitext.gateway = Minitext::TestGateway.new
      Minitext.defaults = {}
    end

    def teardown
      Minitext.gateway.deliveries.clear
    end

    def test_valid_messages_return_true
      assert Message.new(from: '1234567890', to: '5558675309', body: 'This is a test text.').valid?
    end

    def test_invalid_messages_return_false
      assert !Message.new(from: '1234567890', to: '5558675309').valid?
      assert !Message.new(to: '5558675309', body: 'This is a test text.').valid?
      assert !Message.new(from: '1234567890', body: 'This is a test text.').valid?
      assert !Message.new(from: '1234567890', to: '5558675309', body: '').valid?
    end

    def test_invalid_messages_raise_appropriate_exceptions
      assert_raises MissingParameter do
        Message.new(from: '1234567890', to: '5558675309').deliver
      end

      assert_raises MissingParameter do
        Message.new(from: '1234567890', to: '', body: 'This is a test text.').deliver
      end
    end
  end
end
