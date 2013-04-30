require 'sinatra/base'
require 'sinatra-initializers'

require "debugger"
require 'redis'
require 'haml'

# TODO: rename to SCC messaging service == SMS
class SMS < Sinatra::Base
  # register sinatra modules
  register Sinatra::Initializers

  # Sinatra config: http://www.sinatrarb.com/configuration.html
  set :app_file, __FILE__
  set :haml, { :format => :html5, :attr_wrapper => '"' }
  set :inline_templates, true
  set :environments, %w{development test production staging}
  set :environment, ENV['RACK_ENV'] || :development

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

  post '/enqueue' do
    protected!
    REDIS.set("notification", "SMS client sent new notification")
    status 200
  end
end

__END__
@@ index
!!!
%html
  %head
    %title SMS - SCC Messaging Service
  %body
    %h1 SMS - SCC Messaging Service

    %p Email contact address: happy-customer@suse.de
    %p IRC channel: #happy-customer
