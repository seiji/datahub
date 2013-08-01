require "datahub/helpers"
require "curb"
require "nokogiri"
require "mechanize"
require "dropbox_sdk"
require "logger"

module DataHub
  include Helpers
  module Plugin
    module Scrap
      DROPBOX_YAML = File.join(DataHub.root, 'private', 'config', 'dropbox.yml')
      DROPBOX_CONFIG = YAML.load_file(DROPBOX_YAML)["production"]

      def self.included(klass)
        klass.extend ClassMethods
        klass.__send__ :include, InstanceMethods
      end

      module ClassMethods  
      end

      module InstanceMethods
        def initialize(bot, attributes)
          @bot = bot
          @attributes = attributes
          @agent = Mechanize.new
          @agent.user_agent_alias = 'Mac Safari'
#          @agent.log = Logger.new('log.txt')
#          flow = DropboxOAuth2FlowNoRedirect.new(DROPBOX_CONFIG['app_key'], DROPBOX_CONFIG['app_secret'])
          # authorize_url = flow.start()
          # access_token, user_id = flow.finish(code)
          # puts access_token
          # puts user_id

          @dropbox = DropboxClient.new(DROPBOX_CONFIG['access_token'])
        end

        def request(coll)
          execute coll
        end

        def get_doc(url)
          c = Curl::Easy.new(url) do |curl|
            if @bot.config.user_agent
              curl.headers["User-Agent"] = @bot.config.user_agent
            else
              curl.headers["User-Agent"] = Mechanize::AGENT_ALIASES['Mac Safari']
            end
            #    curl.verbose = true
          end
          c.perform
          html_doc = Nokogiri::HTML(c.body_str.to_s)
          html_doc
        end

        def download(url, path)
          Curl::Easy.download(url, path){|curl|
            if @bot.config.user_agent
              curl.headers["User-Agent"] = @bot.config.user_agent
            else
              curl.headers["User-Agent"] = Mechanize::AGENT_ALIASES['Mac Safari']
            end
            curl.follow_location = true;
            curl.max_redirects=10;
          }
        end

        def dropbox_add(file, path, overwrite = false)
          response = @dropbox.put_file(path, open(file), overwrite)
          puts response.inspect
        end

        def dropbox_download(path)
          begin
            @dropbox.get_file_and_metadata(path)
          rescue
            [nil, nil]
          end
        end

        def dropbox_metadata(path)
          begin
            @dropbox.metadata path
          rescue
            nil
          end
        end

      end
    end
  end
end
