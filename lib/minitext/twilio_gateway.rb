require 'twilio-ruby'

module Minitext
  class TwilioGateway
    attr_reader :client

    def initialize(config={})
      sid = config[:sid]
      token = config[:token]
      subaccount = config[:subaccount]
      @client = Twilio::REST::Client.new(sid, token)
      @client = client.accounts.get(subaccount) if subaccount
    end

    def deliver(message)
      params = {
        from: message.from,
        to: message.to,
        body: message.body.strip,
      }

      unless message.media_url.nil?
        params = params.merge(media_url: message.media_url)
      end

      client.messages.create(
        params
      )
    end
  end
end
