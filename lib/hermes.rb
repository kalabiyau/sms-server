require 'sinatra/base'
require 'haml'

class Hermes < Sinatra::Base
  set :app_file, __FILE__
  set :haml, { :format => :html5, :attr_wrapper => '"' }
  set :inline_templates, true

  # start the server if ruby file executed directly
  run! if app_file == $0

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['scc', 'admin']
    end
  end

  get '/' do
    haml :index
  end

  post '/notify' do
    protected!
    status 200
  end
end

__END__
@@ index
!!!
%html
  %head
    %title Hermes - SCC Notification service
  %body
    %h1 Hermes - SCC Notification service

    %p Email contact address: happy-customer@suse.de
    %p IRC channel: #happy-customer
