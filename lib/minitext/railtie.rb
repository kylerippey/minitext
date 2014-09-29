require 'minitext'
require 'rails'

module Minitext
  class Railtie < Rails::Railtie
    config.minitext = ActiveSupport::OrderedOptions.new

    initializer "minitext.configure" do |app|
      Minitext.gateway = app.config.minitext.gateway
    end
  end
end

# Usage:
# development
# config.minitext.gateway = Minitext::TestGateway.new

# production
# config.minitext.gateway = Minitext::TwilioGateway.new(sid: '123', token: 'abc')

# staging
# whitelist = YAML.load_file('twilio_whitelist')
# gateway = Minitext::TwilioGateway.new(sid: '123', token: 'abc')
# config.minitext.gateway = Minitext::WhitelistProxy.new(whitelist: whitelist, gateway: gateway)

