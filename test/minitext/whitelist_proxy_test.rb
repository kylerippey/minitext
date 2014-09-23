require 'test_helper'

module Minitext
  class WhitelistProxyTest < Minitest::Test

    def setup
      Minitext::Base.gateway = Minitext::WhitelistProxy.new('5558675309')
      Minitext.set_defaults({})
    end

    def teardown
      Minitext::Base.gateway.deliveries.clear
    end

    def test_can_deliver_to_whitelisted_recipients
      Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test.').deliver

      assert_equal 1, Minitext::Base.gateway.deliveries.length
    end

    def test_cannot_deliver_to_non_whitelisted_recipients
      Minitext.text(from: '1234567890', to: '5551230987', body: 'This is a test.').deliver

      assert Minitext::Base.gateway.deliveries.empty?
    end
  end
end
