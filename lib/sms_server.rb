require 'rubygems'
require 'sinatra/base'
require 'sinatra-initializers'

class SMSServer < Sinatra::Base
  puts ">> SMSServer application starting in #{ENV['RACK_ENV']}"

  # Register sinatra module
  register Sinatra::Initializers

  # Sinatra config: http://www.sinatrarb.com/configuration.html
  set :app_file, __FILE__
  set :haml, { :format => :html5, :attr_wrapper => '"' }
  set :inline_templates, true
  set :environments, %w{development test production}
  set :environment, ENV['RACK_ENV']

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [CONFIG['sms-server']['username'], CONFIG['sms-server']['password']]
    end
  end

  get '/' do
    haml :index
  end

  post '/enqueue' do
    protected!

    if Notification::Message.new(params).save
      status 200
    else
      status 500
    end
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

    %p Email contact address: #{CONFIG['contact']['email']}
    %p IRC channel: #{CONFIG['irc']['channels'].join(',')}
