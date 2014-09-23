require 'test_helper'

module Minitext
  class DefaultSettingsTest < Minitest::Test

    def setup
      Minitext::Base.gateway = Minitext::TestGateway.new
    end

    def teardown
      Minitext::Base.gateway.deliveries.clear
    end

    def test_default_settings_set
      Minitext.set_defaults(from: '1234567890', to: '5558675309', body: 'This is a test text.')
      assert_equal Message.defaults[:from], '1234567890'
      assert_equal Message.defaults[:to], '5558675309'
      assert_equal Message.defaults[:body], 'This is a test text.'
    end

    def test_single_defaults
      Minitext.set_defaults(from: '1234567890')
      assert Message.new(to: '5558675309', body: 'This is a test text.').valid?, 'Default field not found'

      Minitext.set_defaults(to: '5558675309')
      assert Message.new(from: '1234567890', body: 'This is a test text.').valid?, 'Default field not found'

      Minitext.set_defaults(body: 'default message')
      assert Message.new(from: '1234567890', to: '5558675309').valid?, 'Default field not found'
    end
  end
end

