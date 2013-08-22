require 'bundler'
Bundler.require(:default)
$:.unshift 'lib'

require "datahub/bot"
require "datahub/plugins/twitter/timeline"

bot = DataHub::Bot.new do
  configure do |c|
    c.data_source = :mongo
    c.plugins = [
                 DataHub::Plugins::Twitter::Timeline,
                ]
    c.attributes = {
      "DataHub::Plugins::Twitter::Timeline" => {
        screen_names: %w(orb_alert KanColle_STAFF),
        pubsub_to: "bami2"
      }
    }
  end
end

bot.start
