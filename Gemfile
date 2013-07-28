source "https://rubygems.org"

gem "rake"
gem "curb"
gem "nokogiri"
gem "mechanize"

gem "twitter", :github => "sferik/twitter"
gem "dropbox-sdk"

gem "mongo"
gem "bson_ext"

gem 'whenever', :require => false

group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
end

group :test do
  gem "rspec"
  gem 'webmock', '~> 1.9.0'      #  VCR is known to work with WebMock >= 1.8.0, < 1.10.
  gem 'vcr'
end
