require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'
require 'turn'

# Include hermes.rb file
begin
  require_relative '../lib/hermes.rb'
rescue NameError
  require File.expand_path(File.dirname(__FILE__) + '/../lib/hermes.rb')
end

class MiniTest::Spec
  include Rack::Test::Methods
  def app
    Hermes
  end
end

Turn.config do |c|
 # use one of output formats:
 # :outline  - turn's original case/test outline mode [default]
 # :progress - indicates progress with progress bar
 # :dotted   - test/unit's traditional dot-progress mode
 # :pretty   - new pretty reporter
 # :marshal  - dump output as YAML (normal run mode only)
 # :cue      - interactive testing
 c.format  = :pretty
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end

