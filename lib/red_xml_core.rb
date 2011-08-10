require "redis"
require "xmldb_api/database_manager"

class RedXMLCore
  include DatabaseManager
  def initialize
    @redis = Redis.new
  end
end