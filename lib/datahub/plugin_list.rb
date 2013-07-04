module DataHub
  class PluginList < Array

    def initialize(bot)
      @bot = bot
      super()
    end

    def register_plugin(plugin, attribute)
      self << plugin.new(@bot, attribute)
    end

    def register_plugins(plugins, attributes)
      plugins.each do |plugin|
        register_plugin(plugin, attributes[plugin.to_s])
      end
    end

    def unregister_plugin(plugin)
      plugin.unregister
      delete plugin
    end

    def unregister_plugins(plugins)
      if plugins == self
        plugins = self.dup
      end
      plugins.each {|plugin| unregister_plugin(plugin)}
    end

    def unregister_all
      unregister_plugins(self)
    end
  end
end
