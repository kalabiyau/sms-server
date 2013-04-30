module Notification
  class Message
    # @@namespace = Redis::Namespace.new("notification::messages", :redis => REDIS)

    attr_accessor :id, :state, :text

    def initialize(args={})
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    # === Class methods ===
    class << self
      def namespace
        Redis::Namespace.new("notification::messages", :redis => REDIS)
      end

      def find(id)
        json = self.namespace.get(id)
        self.new(JSON.parse(json).deep_symbolize_keys) if json
      end

      def all
        self.namespace.keys.collect { |id| self.find(id) }
      end

      def destroy_all()
        self.all.each{|s| s.destroy}
      end
    end

    # === Instance methods ===
    def save
      self.class.namespace.set(self.id, self.to_json) == "OK"
    end

    def destroy
      self.class.namespace.del(self.id) == 1 ? true : false
    end

  end
end
