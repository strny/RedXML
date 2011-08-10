require "test/unit"
require "nokogiri"
require "open-uri"

class XMLDBTestCase < Test::Unit::TestCase
#    
 def initialize
    @col = nil
    @config = nil
    @driver = "org.xmldb.api.reference.DatabaseImpl"
    @rootCollection = "child1"
    @collectionURI = "xmldb://child1"
    @uriPrefix = "xmldb://"
    @username = "test"
    @password = "test"
    @quiet = false
    # // Capabilities flags
    @supportsXPath = false
    @supportsBinary = false
    @supportsTransactions = false
    @supportsManagement = false
    @supportsXUpdate = false
    @supportsNested = true
  end

   def setup()
#       
      database = (Database) c.newInstance()
      # DatabaseManager.registerDatabase(database);
#       
      # col =
         # DatabaseManager.getCollection(uriPrefix, username, password);
#       
      # checkCapabilities(database);            
      # initRepository();
# 
      # col.close();
#             
      # col =
         # DatabaseManager.getCollection(collectionURI, username, password);
#       
      # if (col == null) {
         # System.out.println("Collection could not be created");
         # System.exit(-1);
      # }      
   end
#    
   def teardown() 
      # try {
         # if ( supportsManagement ) {
            # col.close();
#             
            # col =
               # DatabaseManager.getCollection(uriPrefix, username, password);
#    
            # CollectionManagementService man = (CollectionManagementService)
               # col.getService("CollectionManagementService", "1.0");
#    
            # // Removing the collections should clear out all data
            # for (int i = 1; i <= 3; i++) {
               # man.removeCollection("child" + i);
            # }
         # }
#             
         # col.close();
      # }
      # catch (Exception e) {
         # e.printStackTrace();
      # }
   end 
# 
   def init_repository()
      # Collection child = null;
#       
      # if ( supportsManagement ) {
         # // Create Collection hierarchy.
         # try {
            # CollectionManagementService man = (CollectionManagementService)
               # col.getService("CollectionManagementService", "1.0");
            # for (int i = 1; i <= 3; i++) {
               # man.createCollection("child" + i);
            # }
#             
            # if ( supportsNested ) {   
               # child = DatabaseManager.getCollection(uriPrefix + "child2", 
                  # username, password);
#       
               # man = (CollectionManagementService)
                  # child.getService("CollectionManagementService", "1.0");
#                
               # man.createCollection("subchild1"); 
            # }
#                         
            # child = DatabaseManager.getCollection(uriPrefix + "child1", 
               # username, password);
#       
            # if ( supportsNested ) {
               # man = (CollectionManagementService)
                  # child.getService("CollectionManagementService", "1.0");
               # for (int i = 1; i <= 2; i++) {
                  # man.createCollection("subchild" + i);
               # }
            # }
         # }
         # catch (Exception e) {
            # // If we get here the collections probably already exist.  
            # // TODO: we mat want to handle this differently
            # child = DatabaseManager.getCollection(uriPrefix + "child1", 
               # username, password);
         # }
#          
         # // Add the sample data.
         # insertResource(child, "test1.xml", XMLResource.RESOURCE_TYPE);
         # insertResource(child, "test2.xml", XMLResource.RESOURCE_TYPE);
         # insertResource(child, "test3.xml", XMLResource.RESOURCE_TYPE);
         # if ( supportsBinary ) {
            # insertResource(child, "image.gif", BinaryResource.RESOURCE_TYPE);
         # }
      # }
   end
   def insert_resource(col, key, type) 
         # throws Exception {
#             
      # FileInputStream file = new FileInputStream("tests/files/" + key);
      # byte[] contents = new byte[file.available()];
      # file.read(contents);
      # file.close();
#       
      # Resource res = col.createResource(key, type);
      # if ( type.equals(XMLResource.RESOURCE_TYPE) ) {
         # res.setContent(new String(contents));
      # }
      # else {
         # res.setContent(contents);
      # }
#       
      # col.storeResource(res);
   end
   def check_capabilities(database)
# 
      # // Check for CollectionManagement support
      # if ( col.getService("CollectionManagementService", "1.0") != null ) {
         # supportsManagement = true;
      # }
      # else {
         # if ( ! quiet ) {
            # System.out.println("This driver does not appear to support the " +
               # "CollectionManagement Service. No auto set of the repository will " +
               # "possible. Make sure your repository has the necessary collections " +
               # "already created.");
         # }
      # }
#       
      # // Check to see if the driver supports XPath
      # if ( Integer.parseInt(database.getConformanceLevel()) >= 1 ) {
         # supportsXPath = true;
      # }
      # else {
         # if ( ! quiet ) {
            # System.out.println("This driver does not appear to support the" +
               # "XPathQueryService. No XPath tests will be performed.");
         # }
      # }
#       
      # // Check for BinaryResource support
      # try {
         # col.createResource(null, BinaryResource.RESOURCE_TYPE);
         # supportsBinary = true;
      # }
      # catch (XMLDBException e) {
         # if ( e.errorCode == ErrorCodes.UNKNOWN_RESOURCE_TYPE ) {
            # if ( ! quiet ) {
               # System.out.println("This driver does not appear to support" +
                  # "BinaryResource. No BinaryResource tests will be performed.");
            # }
         # }
      # }
#       
      # // Check for Transaction Support
      # if ( col.getService("TransactionService", "1.0") != null ) {
         # supportsTransactions = true;
      # }
      # else {
         # if ( ! quiet ) {
            # System.out.println("This driver does not appear to support the " +
               # "TransactionService. No transaction functionality will be tested.");
         # }
      # }
#             
      # // Check for XUpdate support
      # if ( col.getService("XUpdateQueryService", "1.0") != null ) {
         # supportsXUpdate = true;
      # }
      # else {
         # if ( ! quiet ) {
            # System.out.println("This driver does not appear to support the " +
               # "XUpdateQueryService. No XUpdate functionality will be tested.");
         # }
      # }      
   end
  
end