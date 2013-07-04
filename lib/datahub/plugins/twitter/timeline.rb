require "datahub/plugin/twitter"
require "twitter"

module DataHub::Plugins
  module Twitter
    class Timeline
      include DataHub::Plugin::Twitter

      def coll_name
        "twitter_timeline"
      end

      def execute(coll)
        @attributes[:screen_names].each do |screen_name|
          ::Twitter.user_timeline(screen_name).each do |timeline|
            id = timeline[:id]
            if !timeline[:in_reply_to_user_id] and coll.find('_id' => id).count == 0
              coll.insert({_id: id})
              DataHub::Helpers::write_pubsub_message(@attributes[:pubsub_to],
                                                     "[#{screen_name}] #{timeline[:text]}"
                                                     )
            end
          end
        end
      end
    end
  end
end
