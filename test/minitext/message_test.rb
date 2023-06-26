require 'test_helper'

module Minitext
  class MessageTest < Minitest::Test
    def test_message_with_required_params_is_valid
      assert Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.')
    end

    def test_message_with_required_and_optional_params_is_valid
      assert Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.', media_url: 'http://example.com')
    end

    def test_ability_to_pass_gateway
      new_gateway = Minitext::TestGateway.new

      message = Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.', gateway: new_gateway)

      assert_equal new_gateway.object_id, message.gateway.object_id
    end

    def test_invalid_messages_raise_appropriate_exceptions
      assert_raises ArgumentError do
        Minitext.text(from: '1234567890', to: '5558675309')
      end
    end
  end
end
