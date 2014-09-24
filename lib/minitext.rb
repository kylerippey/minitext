module Minitext
  autoload :Message, 'minitext/message'
  autoload :MissingParameter, 'minitext/missing_parameter'
  autoload :TestGateway, 'minitext/test_gateway'
  autoload :TwilioGateway, 'minitext/twilio_gateway'
  autoload :WhitelistProxy, 'minitext/whitelist_proxy'

  @@gateway  = TestGateway.new
  @@defaults = {}

  def self.gateway
    @@gateway
  end

  def self.gateway=(gateway)
    @@gateway = gateway
  end

  def self.defaults
    @@defaults
  end

  def self.defaults=(defaults={})
    @@defaults = defaults
  end

  def self.text(params)
    gateway = params.fetch(:gateway, {})

    if gateway.empty?
      params = params.merge({ gateway: @@gateway })
    end

    Message.new(params)
  end
end

if defined?(Rails)
  require 'minitext/railtie'
end
