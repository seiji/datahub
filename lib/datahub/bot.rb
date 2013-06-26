require "datahub"
require "datahub/config"
require "datahub/helpers"
require "datahub/plugin_list"

require File.expand_path(File.join(*%w[ config environment ]), DataHub.root)
require "mongo"
include Mongo

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
      data_source = @config.data_source
      case data_source
      when :mongo
        mongo_conn = MongoClient.new("localhost", 27017)
        @mongo_connection = mongo_conn 
        @mongo_db = mongo_conn.db('data')
      end
    end

    def start
      @plugins.register_plugins(@config.plugins)
      @plugins.each do |plugin|
        collection_name = plugin.coll_name || plugin.class.to_s.sub(/^DataHub::Plugins::/, "").split("::").map{|n| n.downcase }.join("_")
        coll = @mongo_db[collection_name]
        plugin.request coll
      end
    end
  end
end
