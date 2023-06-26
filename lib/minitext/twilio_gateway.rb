require 'twilio-ruby'

module Minitext
  class TwilioGateway
    attr_reader :account_sid, :auth_token

    def initialize(account_sid:, auth_token:)
      @account_sid = account_sid
      @auth_token = auth_token
    end

    def deliver(message)
      params = {
        messaging_service_sid: message.messaging_service_sid,
        from: message.from,
        to: message.to,
        body: message.body.strip,
        media_url: message.media_url,
      }.compact

      client.messages.create(**params)
    end

    private

    def client
      @client ||= Twilio::REST::Client.new(account_sid, auth_token)
    end
  end
end
