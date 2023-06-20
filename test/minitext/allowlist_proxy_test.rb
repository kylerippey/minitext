require 'test_helper'

module Minitext
  class AllowlistProxyTest < Minitest::Test

    def setup
      Minitext.configure do |config|
        config.gateway = Minitext::AllowlistProxy.new(allowed: ['5558675309'])
      end
    end

    def teardown
      Minitext.configuration.reset!
    end

    def test_can_deliver_to_allowed_recipients
      Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test.').deliver

      assert_equal 1, Minitext.gateway.deliveries.length
    end

    def test_cannot_deliver_to_non_allowed_recipients
      Minitext.text(from: '1234567890', to: '5551230987', body: 'This is a test.').deliver

      assert Minitext.gateway.deliveries.empty?
    end
  end
end
