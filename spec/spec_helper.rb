require "butterfly"

Dir[File.expand_path(File.join(__FILE__, "../support/**/*.rb"))].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end