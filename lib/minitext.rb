# frozen_string_literal: true

require_relative "minitext/allowlist_proxy"
require_relative "minitext/configuration"
require_relative "minitext/message"
require_relative "minitext/test_gateway"
require_relative "minitext/twilio_gateway"
require_relative "minitext/version"

module Minitext
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield(configuration)
  end

  def self.gateway
    configuration.gateway
  end

  def self.text(**kwargs)
    Message.new(**configuration.message_defaults.merge(gateway: configuration.gateway).merge(kwargs))
  end
end

