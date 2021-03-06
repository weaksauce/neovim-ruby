require "rubygems"
require "bundler/setup"
require "neovim"
require "timeout"

require File.expand_path("../support.rb", __FILE__)

if ENV["REPORT_COVERAGE"]
  require "coveralls"
  Coveralls.wear!
end

RSpec.configure do |config|
  config.expect_with :rspec do |exp|
    exp.syntax = :expect
  end

  config.filter_run_excluding :api
  config.disable_monkey_patching!
  config.order = :random

  Kernel.srand config.seed
end

RSpec.shared_examples :remote => true do
  include Support::Remote

  around do |spec|
    with_neovim_client do |client|
      @client = client
      Timeout.timeout(1) { spec.run }
    end
  end
end
