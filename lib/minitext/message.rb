module Minitext
  class Message
    attr_accessor :from, :to, :body, :gateway

    def initialize(params)
      params.merge!(Minitext.defaults).each do |attr, value|
        self.public_send("#{attr}=", value)
      end
    end

    def deliver
      if valid?
        gateway.deliver(self)
      else
        raise_errors
      end
    end

    def valid?
      valid_param?(from) && valid_param?(to) && valid_param?(body)
    end

    protected

    def valid_param?(param)
      !(param.nil? || param.empty?)
    end

    def raise_errors
      case
      when !valid_param?(from)
        raise_missing_parameter('from')
      when !valid_param?(to)
        raise_missing_parameter('to')
      when !valid_param?(body)
        raise_missing_parameter('body')
      end
    end

    protected

    def raise_missing_parameter(param)
      raise Minitext::MissingParameter.new("#{param} parameter cannot be nil or empty")
    end
  end
end
