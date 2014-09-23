require 'test_helper'

module Minitext
  class TestGatewayTest < Minitest::Test

    def setup
      Minitext::Base.gateway = Minitext::TestGateway.new
      Minitext.set_defaults({})
    end

    def teardown
      Minitext::Base.gateway.deliveries.clear
    end

    def test_can_deliver_valid_texts
      assert Minitext::Base.gateway.deliveries.empty?

      Minitext.text(from: '1234567890', to: '5558675309', body: 'This is a test text.').deliver

      assert_equal 1, Minitext::Base.gateway.deliveries.length
    end

    def test_cannot_deliver_invalid_texts

      assert_raises MissingParameter do
        Minitext.text(from: '1234567890', to: '5558675309').deliver
      end

      assert Minitext::Base.gateway.deliveries.empty?
    end
  end
end
