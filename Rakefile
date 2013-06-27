#!/usr/bin/env rake
# Add files as lib/tasks/*.rake
require 'bundler'
Bundler.require(:default)
$:.unshift 'lib'

Dir.glob('lib/tasks/**/*.rake').each { |r| load r }

desc "run script"
task :run, [:name] do |t|
  %x(bundle exec ruby scripts/#{:name}.rb)
end
