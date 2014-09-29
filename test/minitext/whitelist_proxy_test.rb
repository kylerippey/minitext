require 'test_helper'

module Minitext
  class WhitelistProxyTest < Minitest::Test

    def setup
      Minitext.gateway = Minitext::WhitelistProxy.new(whitelist: ['5558675309'])
      Minitext.defaults = {}
    end

    def teardown
      Minitext.gateway.deliveries.clear
    end

    def test_can_deliver_to_whitelisted_recipients
      Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test.').deliver

      assert_equal 1, Minitext.gateway.deliveries.length
    end

    def test_cannot_deliver_to_non_whitelisted_recipients
      Minitext.text(from: '1234567890', to: '5551230987', body: 'This is a test.').deliver

      assert Minitext.gateway.deliveries.empty?
    end
  end
end
