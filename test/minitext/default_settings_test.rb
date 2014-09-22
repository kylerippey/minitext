require 'test_helper'

module Minitext
  class DefaultSettingsTest < Minitest::Test

    def test_default_settings_set
      Minitext.setup defaults: { from: '1234567890', to: '2222222222', body: 'default message' }
      assert_equal Minitext.defaults.from, '1111111111'
      assert_equal Minitext.defaults.to, '2222222222'
      assert_equal Minitext.defaults.body, 'default message'
    end

    def test_single_defaults
      Minitext.setup defaults: { from: '1234567890' }
      assert Message.new(to: '5558675309', body: 'This is a test text.').valid?

      Minitext.setup defaults: { to: '1111111111' }
      assert Message.new(from: '1234567890', body: 'This is a test text.').valid?

      Minitext.setup defaults: { body: '1111111111' }
      assert Message.new(from: '1234567890', to: '5558675309').valid?
    end

    def test_send_without_defaults_raise_exception
      assert_nothing_raised MissingParameter do
        Message.new(from: '1234567890', to: '5558675309').deliver!
      end

      assert_nothing_raised MissingParameter do
        Message.new(to: '5558675309', body: 'This is a test text.').deliver!
      end

      assert_nothing_raised MissingParameter do
        Message.new(to: '5558675309', from: '1234567890').deliver!
      end
    end

  end
end

