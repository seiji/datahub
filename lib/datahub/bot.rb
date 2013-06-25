require "datahub/config"
require "datahub/helpers"
require "datahub/plugin_list"

module DataHub
  class Bot
    include Helpers

    attr_accessor :config
    attr_accessor :plugins

    def configure
      yield @config
    end

    def initialize(&b)
      @config = DataHub::Config.new
      @plugins = DataHub::PluginList.new(self)
      super
      instance_eval(&b) if block_given?
    end

    def start
      @plugins.register_plugins(@config.plugins)
      @plugins.each do |plugin|
        plugin.execute()
      end
    end
  end
end
