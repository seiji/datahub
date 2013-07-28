require 'bundler'
Bundler.require

require "vcr"

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
  config.ignore_hosts('localhost', '127.0.0.1')
  config.default_cassette_options = { record: :new_episodes }
end
