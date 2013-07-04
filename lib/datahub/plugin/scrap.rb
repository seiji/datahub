require "datahub/helpers"
require "curb"
require "nokogiri"
require "mechanize"

module DataHub
  include Helpers

  module Plugin
    module Scrap
      def self.included(klass)
        klass.extend ClassMethods
        klass.__send__ :include, InstanceMethods
      end

      module ClassMethods  
      end

      module InstanceMethods
        def initialize(bot)
          @bot = bot
          @attributes = attributes
        end

        def request(coll)
          urls.each do |url|
            c = Curl::Easy.new(url) do |curl|
              if @bot.config.user_agent
                curl.headers["User-Agent"] = @bot.config.user_agent
              else
                curl.headers["User-Agent"] = Mechanize::AGENT_ALIASES['Mac Safari']
              end
              curl.verbose = true
            end
            c.perform
            html_doc = Nokogiri::HTML(c.body_str.to_s)
            execute coll, url, html_doc
          end
        end

        def urls; []  end
      end
    end
  end
end
