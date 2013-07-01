require 'bundler'
Bundler.require(:default)
$:.unshift 'lib'

require "datahub/bot"
require "datahub/plugins/twitter/timeline/orb_alert"

bot = DataHub::Bot.new do
  configure do |c|
    c.data_source = :mongo
    c.plugins = [
                 DataHub::Plugins::Twitter::Timeline::OrbAlert,
                ]
  end
end

bot.start
