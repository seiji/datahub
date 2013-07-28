require File.dirname(__FILE__) + '/../spec_helper'
require "datahub/bot"
require "datahub/plugins/speakerdeck"

describe DataHub::Plugins::SpeakerDeck do
  describe "#start" do
    it 'should gets a response' do
      VCR.use_cassette('scrap/speakerdeck', :match_requests_on => [:path]) do
        bot = DataHub::Bot.new do
          configure do |c|
            c.plugins = [
                         DataHub::Plugins::SpeakerDeck
                        ]
            c.attributes = {
              "DataHub::Plugins::SpeakerDeck" => {
                urls: ["https://speakerdeck.com/p/all"]
              }
            }
          end
        end
        bot.start
      end
    end
  end
end
