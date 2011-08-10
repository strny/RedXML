require "test/unit"

class CollectionTest < Test::Unit::TestCase
  def test_get_name()
    assert(col.getName().equals("child1"))
  end

  def test_get_parent_collection()
    if ( supports_nested )
      child = col.get_child_collection("subchild1")
      parent = child.get_parent_collection()
      assert(parent.get_name() == "child1")
      # // TODO: need to test behavior on the root collection.
      assert(parent.get_parentCollection().get_parent_collection().nil?);
    end
  end

  def test_get_child_collection_count()
    if ( supportsNested )
      assert(col.get_child_collection_count() == 2)
    else
      assert(col.get_child_collection_count() == 0)
    end
  end
# public void testListChildCollections() {
# try {
# String[] children = col.listChildCollections();
#
# if ( supportsNested ) {
# // We don't want to assume order here
# boolean match1 = false;
# boolean match2 = false;
# for ( int i = 0; i < children.length; i++ ) {
# String child = children[i];
# if ( child.equals("subchild1") )
# match1 = true;
# if ( child.equals("subchild2") )
# match2 = true;
# }
#
# assert(match1 && match2);
#
# try {
# assert(children[2] == null);
# }
# catch (ArrayIndexOutOfBoundsException e) {
# // we should pass if we get this exception
# }
# }
# else {
# assert(children.length == 0);
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
#
# public void testGetChildCollection() {
# try {
# if ( supportsNested ) {
# Collection child = col.getChildCollection("subchild1");
# assert(child.getName().equals("subchild1"));
# }
# else {
# assert(col.getChildCollection("subchild1") == null);
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testGetResourceCount() {
# try {
# // Account for the fact the binary resources are optional
# if ( supportsBinary ) {
# assert(col.getResourceCount() == 4);
# }
# else {
# assert(col.getResourceCount() == 3);
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testListResources() {
# try {
# String[] resources = col.listResources();
# // We don't want to assume order here
# boolean match1 = false;
# boolean match2 = false;
# boolean match3 = false;
# for ( int i = 0; i < resources.length; i++ ) {
# String res = resources[i];
# if ( res.equals("test1.xml") )
# match1 = true;
# if ( res.equals("test2.xml") )
# match2 = true;
# if ( res.equals("test3.xml") )
# match3 = true;
# }
#
# assert(match1 && match2 && match3);
#
# try {
# // TODO: should account for the fact the binary resources are
# // optional
# assert(resources[4] == null);
# }
# catch (ArrayIndexOutOfBoundsException e) {
# // we should pass if we get this exception
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testCreateResource() {
# try {
# // Test for XMLResource and explicit id
# XMLResource res = (XMLResource) col.createResource("test4.xml",
# XMLResource.RESOURCE_TYPE);
# assert(res.getResourceType().equals(XMLResource.RESOURCE_TYPE));
# assert(res.getId().equals("test4.xml"));
#
# // Test for BinaryResource and auto generate id
# if ( supportsBinary ) {
# BinaryResource res2 = (BinaryResource) col.createResource("",
# BinaryResource.RESOURCE_TYPE);
# assert(res2.getResourceType().equals(BinaryResource.RESOURCE_TYPE));
# assert(! res2.getId().equals(""));
# }
#
# // Test for unknown resource type
# try {
# Resource res3 = col.createResource("", "GoogleResource");
# assert(false);
# }
# catch (XMLDBException e) {
# assert(e.errorCode == ErrorCodes.UNKNOWN_RESOURCE_TYPE);
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
#
# public void testStoreResource() {
# String content = "<?xml version=\"1.0\"?><tag1><tag2>value</tag2></tag1>";
# try {
# XMLResource res = (XMLResource) col.createResource("",
# XMLResource.RESOURCE_TYPE);
# res.setContent(content);
# col.storeResource(res);
#
# XMLResource res2 = (XMLResource) col.getResource(res.getId());
# assert(res2 != null);
# assert(res2.getId().equals(res.getId()));
# assert(res2.getContent() != null);
#
# col.removeResource(res);
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testRemoveResource() {
# String content = "<?xml version=\"1.0\"?><tag1><tag2>value</tag2></tag1>";
# try {
# // Create a new resource
# XMLResource res = (XMLResource) col.createResource("",
# XMLResource.RESOURCE_TYPE);
# res.setContent(content);
# col.storeResource(res);
#
# // Verify the resource exists
# XMLResource res2 = (XMLResource) col.getResource(res.getId());
# assert(res2 != null);
# assert(res2.getId().equals(res.getId()));
# assert(res2.getContent() != null);
#
# // Remove the resource
# col.removeResource(res2);
# Resource res3 = col.getResource(res.getId());
# assert(res3 == null);
#
# // Make sure the resource is gone.
# try {
# col.removeResource(res);
# }
# catch (XMLDBException e) {
# assert(e.errorCode == ErrorCodes.NO_SUCH_RESOURCE);
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testGetResource() {
# try {
# // Check for an XML resource
# Resource res = col.getResource("test1.xml");
# assert(res != null);
# assert(res.getResourceType().equals(XMLResource.RESOURCE_TYPE));
# assert(res.getContent() != null);
#
# // Check for a binary resource
# if ( supportsBinary ) {
# res = col.getResource("image.gif");
# assert(res != null);
# assert(res.getResourceType().equals(BinaryResource.RESOURCE_TYPE));
# assert(res.getContent() != null);
# }
#
# // Check for a missing resource
# res = col.getResource("missing.xml");
# assert(res == null);
#
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testXPathQueryService() {
# try {
# if ( supportsXPath ) {
# XPathQueryService serv =
# (XPathQueryService) col.getService("XPathQueryService", "1.0");
# assert(serv != null);
#
# ResourceSet resultSet = serv.query("/data");
# ResourceIterator result = resultSet.getIterator();
#
# int i = 0;
# while (result.hasMoreResources()) {
# result.nextResource();
# i++;
# }
# assert(i == 3);
#
# resultSet = serv.query("/data/child/subchild[@name='subchild1']");
# result = resultSet.getIterator();
# i = 0;
# while (result.hasMoreResources()) {
# result.nextResource();
# i++;
# }
# assert(i == 6);
#
# resultSet = serv.query("/data/child/subchild/subsubchild[@name='subsubchild1']");
# result = resultSet.getIterator();
# i = 0;
# while (result.hasMoreResources()) {
# result.nextResource();
# i++;
# }
# assert(i == 1);
# }
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
#
# public void testStub() {
# try {
#
# } catch (Exception e) {
# fail( e.getMessage( ) );
# }
# }
end