module DataHub
  module Helpers
    def self.write_pubsub_message(channel, message, formats = {})
      mongo_conn = MongoClient.new("localhost", 27017)
      mongo_db = mongo_conn.db('pubsub')
      mongo_coll = mongo_db[channel]
      mongo_coll.insert({message: message, _id: (Time.now.to_f * 1000.0).to_i, formats: formats})
    end
  end
end
