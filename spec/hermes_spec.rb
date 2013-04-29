require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hermes do
  it "in general" do
    wont_be_nil
  end

  it "returns index application name" do
    get '/'
    last_response.body.must_include 'Hermes - SCC Notification service'
    last_response.ok?.must_equal true
  end

  it "grants access for authorized clients" do
    authorize 'scc', 'admin'
    post '/notify'
    last_response.ok?.must_equal true
  end

  it "restricts access for not authorized clients" do
    authorize 'wrong', 'wrong'
    post '/notify'
    last_response.ok?.must_equal false
  end
end
