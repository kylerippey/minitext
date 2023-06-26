require 'test_helper'

module Minitext
  class TestGatewayTest < Minitest::Test
    def setup
      Minitext.gateway.deliveries.clear
    end

    def test_can_deliver_valid_texts
      assert Minitext.gateway.deliveries.empty?

      Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.').deliver

      assert_equal 1, Minitext.gateway.deliveries.length
    end

    def test_cannot_deliver_invalid_texts
      assert_raises ArgumentError do
        Minitext.text(from: '1234567890', to: '5558675309')
      end

      assert Minitext.gateway.deliveries.empty?
    end
  end
end
