# frozen_string_literal: true

require_relative "lib/minitext/version"

Gem::Specification.new do |spec|
  spec.name = "minitext"
  spec.version = Minitext::VERSION
  spec.authors = ["Kyle Rippey"]
  spec.email = ["kylerippey@gmail.com"]

  spec.summary = ""
  spec.description = "A lightweight SMS framework for sending messages via the Twilio API"
  spec.homepage = "http://github.com/kylerippey/minitext"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/kylerippey/minitext"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.test_files = Dir.glob('test/*_test.rb')

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "twilio-ruby", "~> 6.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
