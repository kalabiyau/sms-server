# Define global constans
APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '../../'))
LIB_ROOT = File.expand_path(File.join(APP_ROOT, 'lib'))
RACK_ENV = ENV['RACK_ENV'] || 'development'

# Establesh connection to redis server
REDIS_DATABASES = {:production => 0, :development => 1, :test => 2}
REDIS = Redis.new(:host => "localhost", :port => 6379, :db => REDIS_DATABASES[RACK_ENV.to_sym], :thread_safe => true)

# Load libraries
Dir[File.join(LIB_ROOT,"/**/*.rb")].each {|file| require file }

# Read options from yml file(s)
CONFIG_FILE = "~/.sms/config.yml"
CONFIG = Psych.load_file(File.expand_path(CONFIG_FILE))
