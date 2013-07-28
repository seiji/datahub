require 'bundler'
Bundler.require(:default)
$:.unshift 'lib'

require "datahub/bot"
require "datahub/plugins/twitter/tag"
require "datahub/plugins/twitter/timeline"
require "datahub/plugins/speakerdeck"

bot = DataHub::Bot.new do
  configure do |c|
    c.data_source = :mongo
    c.plugins = [
                 # DataHub::Plugins::Twitter::Tag,
                 # DataHub::Plugins::Twitter::Timeline,
                 DataHub::Plugins::SpeakerDeck
                ]
    c.attributes = {
      "DataHub::Plugins::Twitter::Timeline" => {
        screen_names: %w(ios_dev_bot),
        pubsub_to: "seijit"
      },
      "DataHub::Plugins::Twitter::Tag" => {
        names: %w(#30T),
        pubsub_to: "seijit"
      },
      "DataHub::Plugins::SpeakerDeck" => {
        pubsub_to: "seijit",
        urls: %w(https://speakerdeck.com/p/all)
      }
    }
  end
end

bot.start
