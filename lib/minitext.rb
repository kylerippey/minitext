module Minitext
  autoload :Base, 'minitext/base'
  autoload :Message, 'minitext/message'
  autoload :MissingParameter, 'minitext/errors'
  autoload :TestGateway, 'minitext/test_gateway'
  autoload :TwilioGateway, 'minitext/twilio_gateway'
  autoload :WhitelistProxy, 'minitext/whitelist_proxy'
end

if defined?(Rails)
  require 'minitext/railtie'
end
