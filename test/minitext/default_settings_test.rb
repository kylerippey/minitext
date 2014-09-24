require 'test_helper'

module Minitext
  class DefaultSettingsTest < Minitest::Test

    def setup
      Minitext.gateway = Minitext::TestGateway.new
    end

    def teardown
      Minitext.gateway.deliveries.clear
    end

    def test_default_settings_set
      Minitext.defaults = { from: '1234567890', to: '5558675309', body: 'This is a test text.' }
      assert_equal Minitext.defaults[:from], '1234567890'
      assert_equal Minitext.defaults[:to], '5558675309'
      assert_equal Minitext.defaults[:body], 'This is a test text.'
    end

    def test_single_defaults
      Minitext.defaults = { from: '1234567890' }
      assert Message.new(to: '5558675309', body: 'This is a test text.').valid?, 'Default field not found'

      Minitext.defaults = { to: '5558675309' }
      assert Message.new(from: '1234567890', body: 'This is a test text.').valid?, 'Default field not found'

      Minitext.defaults = { body: 'default message' }
      assert Message.new(from: '1234567890', to: '5558675309').valid?, 'Default field not found'
    end
  end
end

