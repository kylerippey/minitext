module Minitext
  class Base
    class << self
      attr_writer :gateway

      def gateway
        @gateway ||= TestGateway.new
      end
    end
  end

  def self.text(params)
    Message.new(params)
  end
end