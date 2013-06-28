require 'bundler'
Bundler.require(:default)
$:.unshift 'lib'

require "datahub/bot"
require "datahub/plugins/twitter/timeline/orb_alert"
require "datahub/plugins/twitter/timeline/egashura_250"

bot = DataHub::Bot.new do
  configure do |c|
    c.data_source = :mongo
    c.plugins = [
                 DataHub::Plugins::Twitter::Timeline::OrbAlert,
                 DataHub::Plugins::Twitter::Timeline::Egashura250,
                ]
  end
end

bot.start
