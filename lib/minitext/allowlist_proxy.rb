require "set"

module Minitext
  class AllowlistProxy
    attr_reader :allowed, :gateway

    def initialize(allowed:, gateway: nil)
      @allowed = Set.new(allowed)
      @gateway = gateway || TestGateway.new
    end

    def deliver(message)
      gateway.deliver(message) if allowed?(message.to)
    end

    def method_missing(method, *args, &block)
      gateway.send(method, *args, &block)
    end

    def respond_to_missing?(method, *args)
      gateway.respond_to?(method)
    end

    protected

    def allowed?(to)
      allowed.include?(to)
    end
  end
end
