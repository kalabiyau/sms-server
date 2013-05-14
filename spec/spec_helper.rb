ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'turn/autorun'
require 'rack/test'
require 'debugger'
require 'sms_server'

class MiniTest::Spec
  include Rack::Test::Methods
  def app
    Rack::Builder.parse_file(File.join(APP_ROOT, 'config.ru')).first
  end
end

Turn.config do |c|
 c.format  = :pretty
 c.natural = true
end

