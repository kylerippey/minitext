require 'test_helper'

module Minitext
  class DefaultSettingsTest < Minitest::Test

    def setup
      Minitext.gateway = Minitext::TestGateway.new
      Minitext.defaults = {}
    end

    def teardown
      Minitext.gateway.deliveries.clear if !Minitext.gateway.nil?
    end

    def test_single_defaults
      Minitext.defaults = { from: '1234567890' }
      assert Minitext.text(to: '5558675309', body: 'This is a test text.').valid?, 'Default field not found'

      Minitext.defaults = { to: '5558675309' }
      assert Minitext.text(from: '1234567890', body: 'This is a test text.').valid?, 'Default field not found'

      Minitext.defaults = { body: 'default message' }
      assert Minitext.text(from: '1234567890', to: '5558675309').valid?, 'Default field not found'
    end
  end
end

