require "butterfly"
require "pp"

RSPEC_ROOT = File.expand_path(File.join(__FILE__, "../"))

Dir[File.join(RSPEC_ROOT, "support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end