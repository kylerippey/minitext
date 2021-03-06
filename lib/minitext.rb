module Minitext
  autoload :Message, 'minitext/message'
  autoload :MissingParameter, 'minitext/missing_parameter'
  autoload :TestGateway, 'minitext/test_gateway'
  autoload :TwilioGateway, 'minitext/twilio_gateway'
  autoload :WhitelistProxy, 'minitext/whitelist_proxy'

  def self.gateway
    @gateway ||= TestGateway.new
  end

  def self.gateway=(gateway)
    @gateway = gateway
  end

  def self.defaults
    @defaults ||= {}
    {gateway: gateway}.merge(@defaults)
  end

  def self.defaults=(defaults)
    @defaults = defaults
  end

  def self.text(params)
    Message.new(defaults.merge(params))
  end
end

if defined?(Rails)
  require 'minitext/railtie'
end
