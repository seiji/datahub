#! ruby
require 'bundler'
Bundler.require(:default)
$:.unshift 'lib'

require "datahub"
require "datahub/plugins/speakerdeck"

bot = DataHub::Bot.new do
  configure do |c|
    c.user_agent = "user.agent"
    c.plugins = [
                 DataHub::Plugins::Speakerdeck
                ]
  end
end

bot.start
