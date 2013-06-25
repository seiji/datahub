require "datahub/plugin/scrap"

module DataHub::Plugins
  class Speakerdeck
    include DataHub::Plugin::Scrap

    def execute(m)
      puts "execute"
    end
    
  end
end
