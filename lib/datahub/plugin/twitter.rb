require "datahub/helpers"
require "twitter"

module DataHub
  include Helpers
  module Plugin
    module Twitter
      TWITTER_YAML = File.join(DataHub.root, 'private', 'config',  'twitter.yml')
      TWITTER_CONFIG = YAML.load_file(TWITTER_YAML)["production"]

      def self.included(klass)
        klass.extend ClassMethods
        klass.__send__ :include, InstanceMethods
      end

      module ClassMethods  
      end

      module InstanceMethods
        def initialize(bot)
          @bot = bot
          ::Twitter.configure do |config|
            config.consumer_key       = TWITTER_CONFIG['consumer_key']
            config.consumer_secret    = TWITTER_CONFIG['consumer_secret'] 
            config.oauth_token        = TWITTER_CONFIG['oauth_token']
            config.oauth_token_secret = TWITTER_CONFIG['oauth_token_secret']
          end
        end

        def request(coll)
          execute coll
        end

        def coll_name ; end
      end
    end
  end
end
