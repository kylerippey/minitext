module Minitext
  autoload :Message, 'minitext/message'
  autoload :MissingParameter, 'minitext/missing_parameter'
  autoload :TestGateway, 'minitext/test_gateway'
  autoload :TwilioGateway, 'minitext/twilio_gateway'
  autoload :WhitelistProxy, 'minitext/whitelist_proxy'

  @@gateway = TestGateway.new

  def self.gateway=(gateway=nil)
    @@gateway = gateway
  end

  def self.gateway
    @@gateway
  end

  def self.set_defaults(params={})
    Message.defaults = params
  end

  def self.text(params)
    gateway = params.fetch(:gateway, {})

    unless gateway.empty?
      @@gateway = gateway
    end

    Message.new(params)
  end
end

if defined?(Rails)
  require 'minitext/railtie'
end
