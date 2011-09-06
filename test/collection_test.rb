require "test/unit"

class CollectionTest < XMLDBTestCase
  def test_get_name()
    assert(col.get_name()=="child1")
  end

  def test_get_parent_collection()
    if ( supports_nested? )
      child = col.get_child_collection("subchild1")
      parent = child.get_parent_collection()
      assert(parent.get_name() == "child1")
      # // TODO: need to test behavior on the root collection.
      assert(parent.get_parentCollection().get_parent_collection().nil?);
    end
  end

  def test_get_child_collection_count()
    if ( supports_nested? )
      assert(col.get_child_collection_count() == 2)
    else
      assert(col.get_child_collection_count() == 0)
    end
  end
  
  def test_list_child_collections() 
    children = col.list_child_collections()

    if ( supports_nested? ) 
      # // We don't want to assume order here
      match1 = false
      match2 = false
      children.each do |child|
        match1 = true if ( child.equals("subchild1") )
        match2 = true if ( child.equals("subchild2") )
      end
      assert(match1 && match2)
      assert(children[2].nil?)
    else 
      assert(children.size == 0);
    end
  end

  def test_get_child_collection() 
    if ( supports_nested? ) 
      child = col.get_child_collection("subchild1")
      assert(child.get_name()=="subchild1")
    else 
      assert(col.get_child_collection("subchild1").nil?);
    end
  end


  def test_get_resource_count()
    # // Account for the fact the binary resources are optional
    if ( supports_binary? )
      assert(col.get_resource_count() == 4)
    else 
      assert(col.get_resource_count() == 3)
    end
  end
  
  def test_list_resources()
    resources = col.list_resources()
    # // We don't want to assume order here
    match1 = false
    match2 = false
    match3 = false
    resources.each do |res|
      res = resources[i];
      match1 = true if ( res=="test1.xml" )
      match2 = true if ( res=="test2.xml" )
      match3 = true if ( res=="test3.xml" )
    end
    assert(match1 && match2 && match3)

    # // TODO: should account for the fact the binary resources are
    # // optional
    assert(resources[4].nil?)
  end
  
  def test_create_resource()
    # // Test for XMLResource and explicit id
    res = col.create_resource("test4.xml",
                              XMLResource::RESOURCE_TYPE)
    assert(res.get_resource_type()==XMLResource::RESOURCE_TYPE)
    assert(res.get_id()=="test4.xml")

    # // Test for BinaryResource and auto generate id
    if ( supports_binary? )
      res2 = col.create_resource("",
                                 BinaryResource::RESOURCE_TYPE)
      assert(res2.get_resource_type()==BinaryResource::RESOURCE_TYPE)
      assert_false(res2.get_id()=="")
    end

    # // Test for unknown resource type
    begin
      res3 = col.create_resource("", "GoogleResource")
      assert(false)
    rescue XMLDBException => e
      assert(e.error_code == ErrorCodes::UNKNOWN_RESOURCE_TYPE)
    end
  end


  def test_store_resource()
    content = "<?xml version=\"1.0\"?><tag1><tag2>value</tag2></tag1>"
    res = col.create_resource("",
                              XMLResource::RESOURCE_TYPE)
    res.set_content(content)
    col.store_resource(res)

    res2 = col.get_resource(res.get_id())
    assert_false(res2.nil?)
    assert(res2.get_id()==res.get_id())
    assert_false(res2.get_content().nil?)

    col.remove_resource(res)
  end
  
  def test_remove_resource()
    content = "<?xml version=\"1.0\"?><tag1><tag2>value</tag2></tag1>"
    res = col.create_resource("",
                              XMLResource::RESOURCE_TYPE)
    res.set_content(content)
    col.store_resource(res)

    res2 = col.get_resource(res.get_id())
    assert_false(res2.nil?)
    assert(res2.get_id()==res.get_id())
    assert_false(res2.get_content().nil?)

    col.remove_resource(res)
    res3 = col.get_resource(res.get_id())
    assert(res3.nil?)

    # // Make sure the resource is gone.
    begin
      col.remove_resource(res)
    rescue XMLDBException=>e
      assert(e.errorCode == ErrorCodes::NO_SUCH_RESOURCE)
    end
  end

  def test_get_resource()
  # // Check for an XML resource
    res = col.get_resource("test1.xml")
    assert_false(res.nil?)
    assert(res.get_resource_type()==XMLResource::RESOURCE_TYPE)
    assert_false(res.get_content().nil?)

  # // Check for a binary resource
    if ( supports_binary? ) 
      res = col.get_resource("image.gif")
      assert_false(res.nil?)
      assert(res.get_resource_type()==BinaryResource::RESOURCE_TYPE)
      assert_false(res.get_content().nil?)
    end

  # // Check for a missing resource
    res = col.get_resource("missing.xml")
    assert(res.nil?)
  end
  
  
  def test_XPath_query_service()
    if ( supports_XPath? ) 
      serv = col.get_service("XPathQueryService", "1.0")
      assert_false(serv.nil?)
      resultSet = serv.query("/data")
      result = resultSet.get_iterator()
      i = 0
      while (result.has_more_resources?) do
        result.next_resource()
        i = i + 1
      end
      assert(i == 3)

      resultSet = serv.query("/data/child/subchild[@name='subchild1']")
      result = resultSet.get_iterator()
      i = 0
      while (result.has_more_resources()) do
        result.next_resource()
        i = i + 1
      end
      assert(i == 6)

      resultSet = serv.query("/data/child/subchild/subsubchild[@name='subsubchild1']")
      result = resultSet.get_iterator()
      i = 0
      while (result.has_more_resources()) do
        result.next_resource()
        i = i + 1
      end
      assert(i == 1)
    end
  end
end