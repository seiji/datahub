require "datahub/plugin/scrap"

module DataHub::Plugins
  class Speakerdeck
    include DataHub::Plugin::Scrap

    def urls
      ["http://blog.seiji.me"]
    end
    
    def execute(storage, response)
      p response
    end
    
  end
end
