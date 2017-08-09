$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pricefinder'
require 'pricefinder/error'
require 'byebug'
require 'webmock/rspec'
require 'support/shared_configuration'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  # c.debug_logger = $stderr

  c.filter_sensitive_data('<PRICEFINDER_CLIENT_ID>') { ENV['PRICEFINDER_CLIENT_ID'] }
  c.filter_sensitive_data('<PRICEFINDER_CLIENT_SECRET>') { ENV['PRICEFINDER_CLIENT_SECRET'] }
end