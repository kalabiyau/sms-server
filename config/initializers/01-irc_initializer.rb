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
          CONFIG['irc']['channels'].each do |channel|
            success = Channel(channel).send("#{message.sender}: #{message.text}")
            message.destroy if success
          end
        end
      end
    end

    bot = Cinch::Bot.new do
      configure do |c|
        c.nick = CONFIG['irc']['nick']
        c.server = CONFIG['irc']['server']
        c.channels = CONFIG['irc']['channels']
        c.verbose = false
        c.plugins.plugins = [SMSPlugin]
        c.log = self.loggers.first
      end
    end

    bot.start
  end
end
