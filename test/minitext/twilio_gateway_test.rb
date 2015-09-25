require 'test_helper'
require 'twilio-ruby'

module Minitext
  class TwilioGatewayTest < Minitest::Test

    def setup
      messages_mock = mock()
      messages_mock.expects(:create).with({to: '5558675309', from: '1234567890', body: 'This is a test.'}).returns(true)

      Twilio::REST::Client.any_instance.expects(:messages).returns(messages_mock)

      Minitext.gateway = Minitext::TwilioGateway.new(sid: '123', token: 'abc')
      Minitext.defaults = {}
    end

    def test_can_deliver_valid_messages_to_twilio
      Minitext.text(to: '5558675309', from: '1234567890', body: 'This is a test.').deliver
    end
  end
end
