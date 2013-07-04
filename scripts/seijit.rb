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
        screen_names: %w(ios_dev_bot),
        pubsub_to: seijit"
      }
    }
  end
end

bot.start
