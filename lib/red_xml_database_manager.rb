require "redis"
require "xmldb_api/database_manager"

class RedXMLDatabaseManager
  include DatabaseManager
  def initialize
    @redis = Redis.new
  end
  
end