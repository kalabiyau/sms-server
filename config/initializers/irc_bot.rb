if ENV['RACK_ENV'] != 'test'
  require 'cinch'

  # Redirect $stderr to log file
  $stderr = File.new('log/irc.log', 'w')
  $stderr.sync = true

  IRC = Thread.new do
    class TimedPlugin
      include Cinch::Plugin

      timer 5, method: :timed
      def timed
        notification = get_notifications()
        Channel("#sms").send "You have new IRC notification" if notification
        Channel("#sms").send notification if notification

        REDIS.del("notification")
      end

      def get_notifications
        self.log "*** Get notification messages"
        value = REDIS.get("notification")
        return value
      end
    end

    bot = Cinch::Bot.new do
      configure do |c|
        c.nick = "sms"
        c.server = "irc.suse.de"
        c.channels = ["#sms"]
        c.verbose = false
        c.plugins.plugins = [TimedPlugin]
        c.log = self.loggers.first
      end
    end

    bot.start
  end
end
