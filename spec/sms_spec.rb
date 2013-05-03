require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SMS do
  before(:each){ Notification::Message.destroy_all }

  it "establishes a REDIS connection" do
    REDIS.wont_be_nil
    REDIS.client.db.must_equal 2
  end

  it "access index page" do
    get '/'
    last_response.body.must_include 'SMS - SCC Messaging Service'
    last_response.ok?.must_equal true
  end

  it "grants access for authorized clients" do
    authorize 'scc', 'admin'
    post '/enqueue'
    last_response.status.must_equal 200
  end

  it "restricts access for not authorized clients" do
    authorize 'wrong', 'wrong'
    post '/enqueue'
    last_response.status.must_equal 401
  end

  it "enqueues new notification" do
    authorize 'scc', 'admin'
    Notification::Message.all.count.must_equal 0

    post '/enqueue', :type => "test", :text => "Test message"

    Notification::Message.all.count.must_equal 1
    last_response.status.must_equal 200
  end
end
