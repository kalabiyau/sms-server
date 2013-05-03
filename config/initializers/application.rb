APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '../../'))
LIB_ROOT = File.expand_path(File.join(APP_ROOT, 'lib'))

# Establesh connection to redis server
REDIS = Redis.new(:host => "localhost", :port => 6379, :db => 'sms_db', :thread_safe => true)

Dir[File.join(LIB_ROOT,"/**/*.rb")].each do |file|
  require file
end

CONFIG_FILE = "~/.sms/config.yml"
CONFIG = Psych.load_file(File.expand_path(CONFIG_FILE))
