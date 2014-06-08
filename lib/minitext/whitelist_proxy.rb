module Minitext
  class WhitelistProxy
    attr_reader :whitelist, :gateway
    
    def initialize(whitelist=[], gateway=TestGateway.new)
      @whitelist = Array(whitelist)
      @gateway = gateway
    end

    def deliver(message)
      gateway.deliver(message) if whitelisted?(message.to)
    end

    def method_missing(method, *args, &block)
      gateway.send(method, *args, &block)
    end

    protected

    def whitelisted?(recipient)
      whitelist.include?(recipient)
    end
  end
end