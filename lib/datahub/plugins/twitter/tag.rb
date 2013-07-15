require "datahub/plugin/twitter"
require "twitter"

module DataHub::Plugins
  module Twitter
    class Tag
      include DataHub::Plugin::Twitter

      def coll_name
        "twitter_timeline"
      end

      def execute(coll)
        require "pp"
        @attributes[:names].each do |name|
          ::Twitter.search("#{name} -rt", :lang => "ja").results.each do |tweet|
            id = tweet[:id]
            user = tweet[:user]
            pp tweet
            # if coll.find('_id' => id).count == 0
            #   coll.insert({_id: id})
            DataHub::Helpers::write_pubsub_message(@attributes[:pubsub_to],
                                                   "[#{user[:name]} #{tweet[:text]}"
                                                   )
            # end
          end
        end
      end
    end
  end
end
