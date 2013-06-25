require "datahub/helpers"
module DataHub
  include Helpers
  module Plugin
    module Scrap
      module ClassMethods  
        def initialize(bot)
          @bot = bot
#          __register
        end

      end
      
      def self.included(by)
        by.extend ClassMethods
      end
    end
  end
end
