if ENV['RACK_ENV'] != 'test'
  require 'cinch'

  # Redirect $stderr to log file
  $stderr = File.new('log/irc.log', 'w')
  $stderr.sync = true

  IRC = Thread.new do
    class SMSPlugin
      include Cinch::Plugin

      timer 5, method: :notify
      def notify
        Notification::Message.all.each do |message|
          success = Channel("#sms").send("#{message.type}: #{message.text}")
          message.destroy if success
        end
      end
    end

    bot = Cinch::Bot.new do
      configure do |c|
        c.nick = "sms"
        c.server = "irc.suse.de"
        c.channels = ["#sms"]
        c.verbose = false
        c.plugins.plugins = [SMSPlugin]
        c.log = self.loggers.first
      end
    end

    bot.start
  end
end
