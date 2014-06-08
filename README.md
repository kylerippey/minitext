# minitext

A simple little gem to send SMS messages.

## Installation

In your Gemfile add:
```
gem 'minitext'
```

Install your gems:
```
bundle install
```

## Usage

First set up a gateway:
```
Minitext::Base.gateway = Minitext::TwilioGateway.new(sid: 'your_twilio_sid', token: 'your_twilio_token')
```

Then send some texts:
```
Minitext.text(from: '1234567890', to: '9876543210', body: 'Hello world').deliver!
```

### Whitelist proxy

If you want to restrict the numbers that you can send texts to, use the `WhitelistProxy` wrapper.

Set up your whitelist proxy:
```
whitelist = ['9876543210']
gateway = Minitext::TwilioGateway.new(sid: 'your_twilio_sid', token: 'your_twilio_token')
Minitext::Base.gateway = Minitext::WhitelistProxy.new(whitelist, gateway)
```

Then send some texts:
```
Minitext.text(from: '1234567890', to: '9876543210', body: 'This text should succeed.').deliver!

Minitext.text(from: '1234567890', to: '5559991111', body: 'This text should silently fail.').deliver!
```
