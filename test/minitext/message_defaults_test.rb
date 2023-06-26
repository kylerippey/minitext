require 'test_helper'

module Minitext
  class MessageDefaultsTest < Minitest::Test
    def setup
      Minitext.configuration.reset!
    end

    def teardown
      Minitext.configuration.reset!
    end

    def test_default_from
      Minitext.configure do |config|
        config.message_defaults = { from: '1234567890' }
      end

      message = Minitext.text(to: '5558675309', body: 'This is a test text.')

      assert_equal message.from, "1234567890"
    end

    def test_message_overrides_defaults
      Minitext.configure do |config|
        config.message_defaults = { from: '1234567890' }
      end

      message = Minitext.text(from: '9999999999', to: '5558675309', body: 'This is a test text.')

      assert_equal(message.from, "9999999999")
    end

    def test_default_to
      Minitext.configure do |config|
        config.message_defaults = { to: '5558675309' }
      end

      message = Minitext.text(from: '1234567890', body: 'This is a test text.')

      assert_equal message.to, "5558675309"
    end

    def test_default_body
      Minitext.configure do |config|
        config.message_defaults = { body: 'default message' }
      end

      message = Minitext.text(from: '1234567890', to: '5558675309')

      assert_equal message.body, "default message"
    end
  end
end
