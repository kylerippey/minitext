require 'test_helper'

module Minitext
  class MessageTest < Minitest::Test
    def setup
      Minitext.gateway = Minitext::TestGateway.new
    end

    def test_message_with_required_params_is_valid
      assert Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.').valid?
    end

    def test_message_with_required_and_optional_params_is_valid
      assert Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.', media_url: 'http://example.com').valid?
    end

    def test_message_missing_body_is_invalid
      assert !Minitext.text(from: '1234567890', to: '5558675309').valid?
    end

    def test_message_with_blank_body_is_invalid
      assert !Minitext.text(from: '1234567890', to: '5558675309', body: '').valid?
    end

    def test_message_missing_from_is_invalid
      assert !Minitext.text(to: '5558675309', body: 'This is a test text.').valid?
    end

    def test_message_missing_to_is_invalid
      assert !Minitext.text(from: '1234567890', body: 'This is a test text.').valid?
    end

    def test_invalid_messages_with_blank_media_url_is_invalid
      assert !Minitext.text(from: '1234567890', to: '5558675309', body: 'test body', media_url: '').valid?
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
