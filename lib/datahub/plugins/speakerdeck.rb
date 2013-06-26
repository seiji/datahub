require "datahub/plugin/scrap"

module DataHub::Plugins
  class Speakerdeck
    include DataHub::Plugin::Scrap

    def urls
      ["http://blog.seiji.me"]
    end
    
    def execute(coll, url, response)
      coll.insert({'a' => url})
      
    end
  end
end
