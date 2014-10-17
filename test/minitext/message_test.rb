require 'test_helper'

module Minitext
  class MessageTest < Minitest::Test
    def setup
      Minitext.gateway = Minitext::TestGateway.new
    end

    def test_valid_messages_return_true
      assert Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.').valid?
    end

    def test_invalid_messages_return_false
      assert !Minitext.text(from: '1234567890', to: '5558675309').valid?
      assert !Minitext.text(to: '5558675309', body: 'This is a test text.').valid?
      assert !Minitext.text(from: '1234567890', body: 'This is a test text.').valid?
      assert !Minitext.text(from: '1234567890', to: '5558675309', body: '').valid?
    end

    def test_ability_to_pass_gateway
      new_gateway = Minitext::TestGateway.new

      message = Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.', gateway: new_gateway)

      assert_equal new_gateway.object_id, message.gateway.object_id
    end

    def test_invalid_messages_raise_appropriate_exceptions
      assert_raises MissingParameter do
        Minitext.text(from: '1234567890', to: '5558675309').deliver!
      end

      assert_raises MissingParameter do
        Minitext.text(from: '1234567890', to: '', body: 'This is a test text.').deliver!
      end
    end
  end
end
