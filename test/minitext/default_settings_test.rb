require 'test_helper'

module Minitext
  class DefaultSettingsTest < Minitest::Test

    def test_default_settings_set
      Message.defaults = { from: '1234567890', to: '2222222222', body: 'default message' }
      assert_equal Message.defaults[:from], '1234567890'
      assert_equal Message.defaults[:to], '2222222222'
      assert_equal Message.defaults[:body], 'default message'
    end

    def test_single_defaults
      Message.defaults = { from: '1234567890' }
      assert Message.new(to: '5558675309', body: 'This is a test text.').valid?, 'Default field not found'

      Message.defaults = { to: '1111111111' }
      assert Message.new(from: '1234567890', body: 'This is a test text.').valid?, 'Default field not found'

      Message.defaults = { body: 'This is a test' }
      assert Message.new(from: '1234567890', to: '5558675309').valid?, 'Default field not found'
    end
  end

end

