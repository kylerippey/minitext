module Minitext
  class TestGateway
    attr_reader :deliveries

    def initialize
      @deliveries = []
    end

    def deliver(message)
      @deliveries << message
    end
  end
end