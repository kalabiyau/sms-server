require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hermes do
  it "establishes a REDIS connection" do
    REDIS.wont_be_nil
  end

  it "access index page" do
    get '/'
    last_response.body.must_include 'Hermes - SCC Notification service'
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
end
