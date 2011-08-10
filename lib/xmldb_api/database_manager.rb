module DatabaseManager
  URI_PREFIX = "xmldb:"
  
  def get_databases() 
    return @storage.get_databases()
  end
  
  def register_database(database)
         # if ((database.getName() == null) || (database.getName().equals(""))) {
         # throw new XMLDBException(ErrorCodes.INVALID_DATABASE);
      # }
#       
      # databases.put(database.getName(), database);
#  
    
    @storage.find_database(database)
    
  end    

   
   def deregister_database(database) 
         
   end
   
  
   def get_collection(uri)
      
   end      
   
   
   def get_collection(uri, username, password)
#      Database db = getDatabase(uri);
     
#      uri = stripURIPrefix(uri);
      
#      return (org.xmldb.api.base.Collection) db.getCollection(uri, username, 
#         password);   
   end
   
   def get_conformance_level(uri)
      
   end
   
   
   def get_property(name)
   
   end

      
   def set_property (name, value)
   
   end
   
   
   def get_database(uri)
      # if (!uri.startsWith(URI_PREFIX)) {
         # throw new XMLDBException(ErrorCodes.INVALID_URI);
      # }
#       
      # int end = uri.indexOf(":", URI_PREFIX.length());      
      # if (end == -1) {
         # throw new XMLDBException(ErrorCodes.INVALID_URI);
      # }
#       
      # String databaseName = uri.substring(URI_PREFIX.length(), end);
#       
      # Database db = (Database) databases.get(databaseName); 
      # if (db == null) {
         # throw new XMLDBException(ErrorCodes.NO_SUCH_DATABASE);         
      # }
#       
      # return db;
   end
   
   # /**
    # * Removes the URI_PREFIX from the front of the URI. This is so the database
    # * can focus on handling its own URIs.
    # *
    # * @param uri The full URI to strip.
    # * @return The database specific portion of the URI.
    # */
private
   def strip_URI_prefix(uri)
      # if (!uri.startsWith(URI_PREFIX)) {
         # throw new XMLDBException(ErrorCodes.INVALID_URI);
      # }
#                   
      # String dbURI = uri.substring(URI_PREFIX.length(), uri.length());
      # return dbURI;
   end
end