require "datahub/plugin/twitter"
require "twitter"

module DataHub::Plugins
  module Twitter
    module Timeline
      class OrbAlert
        include DataHub::Plugin::Twitter

        SCREEN_NAME = "orb_alert"

        def coll_name
          "twitter_bot"
        end

        def execute(coll)
          ::Twitter.user_timeline(SCREEN_NAME).each do |timeline|
            id = timeline[:id]
            
            if coll.find('_id' => id).count == 0
              coll.insert({_id: id})
              DataHub::Helpers::write_pubsub_message("bami2", "[#{SCREEN_NAME}] #{timeline[:text]}")
            end
          end
        end
      end
    end
  end
end
