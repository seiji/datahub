require "datahub/plugin/twitter"
require "twitter"

module DataHub::Plugins
  module Twitter
    module Timeline
      class OrbAlert
        include DataHub::Plugin::Twitter

        SCREEN_NAME = "orb_alert"
        def coll_name
          "twitter"
        end
        
        def execute(coll)
          ::Twitter.user_timeline(SCREEN_NAME).each do |timeline|
            puts "#{timeline[:created_at]} [#{SCREEN_NAME}] #{timeline[:text]}"
          end
        end
      end
    end
  end
end
