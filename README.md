# minitext

A simple SMS framework for sending messages via Twilio.


## Installation

In your Gemfile add:
```ruby
gem "minitext"
```

Install your gems:
```bash
bundle install
```


## Usage

First set up a gateway:
```ruby
Minitext.configure do |config|
  config.gateway = Minitext::TwilioGateway.new(account_sid: 'your_twilio_account_sid', auth_token: 'your_twilio_auth_token')
end
```

Then send some texts:
```ruby
Minitext.text(from: '1234567890', to: '9876543210', body: 'Hello world').deliver
```

You can send using a Twilio Messaging Service instead of a from number by specifying it's SID:
```ruby
Minitext.text(messaging_service_sid: 'your-messaging-service-sid', to: '9876543210', body: 'Hello world').deliver
```

You can send mms texts with a media_url:
```ruby
Minitext.text(from: '1234567890', to: '9876543210', body: 'Hello world', media_url: 'http://placekitten.com/200/300').deliver
```

### Allowlist proxy

If you want to restrict the numbers that you can send texts to, use the `AllowlistProxy` wrapper.

Set up your allowlist proxy:
```ruby
Minitext.configure do |config|
  allowlist = ['9876543210']
  twilio_gateway = Minitext::TwilioGateway.new(account_sid: 'your_twilio_account_sid', auth_token: 'your_twilio_auth_token')

  config.gateway = Minitext::AllowlistProxy.new(allowed: allowlist, gateway: twilio_gateway)
end
```

Then send some texts:
```ruby
Minitext.text(from: '1234567890', to: '9876543210', body: 'This text should succeed.').deliver

Minitext.text(from: '1234567890', to: '5559991111', body: 'This text should fail.').deliver
```


## Rails configuration

Here are some examples of how you might configure Minitext in different Rails environments.

### Production
```ruby
Minitext.configure do |config|
  config.gateway = Minitext::TwilioGateway.new(account_sid: '123', auth_token: 'abc')

  # You can set a default `from` number for all messages if you don't want to specify it everywhere you call Minitext.text
  # config.message_defaults = { from: '5551234567' }

  # Or, you can specify a messaging_service_sid instead:
  # config.message_defaults = { messaging_service_sid: 'your_default_messaging_service_sid' }
end
```

### Test
```ruby
Minitext.configure do |config|
  config.gateway = Minitext::TestGateway.new
end
```

### Development
```ruby
Minitext.configure do |config|
  # You could allow devs to send messages to themselves in development mode if they start the server with an
  # environment variable, like so: `SEND_LIVE_SMS_TO=5551234567 rails s`

  allowlist = Array(ENV.fetch("SEND_LIVE_SMS_TO", nil)).compact
  twilio_gateway = Minitext::TwilioGateway.new(account_sid: '123', auth_token: 'abc')

  config.gateway = Minitext::AllowlistProxy.new(allowed: allowlist, gateway: twilio_gateway)
end
```


## Testing

If you do not specify a gateway via configuration, Minitext uses a `TestGateway` object by default.

Example test:
```ruby
Minitext.text(from: '1234567890', to: '9876543210', body: 'This text should succeed.').deliver

assert_equal 1, Minitext.gateway.deliveries.length
```

Don't forget to cleanup after yourself in your teardown methods:
```ruby
Minitext.gateway.deliveries.clear
```
