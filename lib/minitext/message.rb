module Minitext
  class Message
    attr_accessor :from, :to, :body, :gateway, :media_url

    def initialize(params)
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end
    end

    def deliver!
      deliver || raise_errors
    end

    def deliver
      return false unless valid?
      !!gateway.deliver(self)
    end

    def valid?
      valid_param?(from) && valid_param?(to) && valid_param?(body) && valid_optional_param?(media_url) && !gateway.nil?
    end

    protected

    def valid_optional_param?(param)
      param.nil? || valid_param?(param)
    end

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
