Gem::Specification.new do |s|
  s.name = "minitext"
  s.version = "0.0.3"
  s.description = 'A lightweight SMS framework'
  s.summary = ''

  s.license = "MIT"

  s.authors = ["Kyle Rippey"]
  s.email = "kylerippey@gmail.com"
  s.homepage = "http://github.com/kylerippey/minitext"

  s.add_dependency 'twilio-ruby'

  s.files = Dir["lib/**/*"] + ["Rakefile"]
  s.test_files = Dir.glob('test/*_test.rb')
end
