APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '../../'))
LIB_ROOT = File.expand_path(File.join(APP_ROOT, 'lib'))

# establesh connection to redis server
REDIS = Redis.new(:host => "localhost", :port => 6379, :db => 'sms_db', :thread_safe => true)

# auto load
Dir[File.join(File.dirname(APP_ROOT),"{lib,models}/**/*.rb")].each do |file|
  require file
end


