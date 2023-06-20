module Minitext
  class Configuration
    attr_accessor :gateway, :message_defaults

    def initialize
      @gateway = TestGateway.new
      @message_defaults = {}
    end

    def reset!
      @gateway = TestGateway.new
      @message_defaults = {}
    end
  end
end
