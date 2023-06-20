module Minitext
  class Message
    attr_accessor :from, :messaging_service_sid, :to, :body, :gateway, :media_url

    def initialize(to:, body:, gateway:, from: nil, messaging_service_sid: nil, media_url: nil)
      if from.nil? && messaging_service_sid.nil?
        raise ArgumentError.new("must supply either the 'from' or 'messaging_service_sid' argument")
      end

      @gateway = gateway
      @messaging_service_sid = messaging_service_sid
      @from = from
      @to = to
      @body = body
    end

    def deliver
      gateway.deliver(self)
    end
  end
end
