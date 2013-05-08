ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'minitest/autorun'
require 'minitest/spec'
require 'turn/autorun'
require 'rack/test'

# Include sms.rb file
begin
  require_relative '../lib/sms.rb'
rescue NameError
  require File.expand_path(File.dirname(__FILE__) + '/../lib/sms.rb')
end

class MiniTest::Spec
  include Rack::Test::Methods
  def app
    Rack::Builder.parse_file(File.dirname(__FILE__) + '/../config.ru').first
  end
end

Turn.config do |c|
 c.format  = :pretty
 c.natural = true
end

