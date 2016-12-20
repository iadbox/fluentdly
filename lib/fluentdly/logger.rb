module Fluentdly
  class Logger

    def initialize config
      @host     = config.fetch(:host,     'localhost')
      @port     = config.fetch(:port,     24224)
      @app_name = config.fetch(:app_name, 'myapp')
    end

    def log severity, content
      message = content.merge(:severity => severity)
      adapter.post(severity, message)
    end

   def info content
     log Severity.info, content
   end

   def warn content
     log Severity.warn, content
   end

   def debug content
     log Severity.debug, content
   end

   def error content
     log Severity.error, content
   end

   def fatal content
     log Severity.fatal, content
   end

   def unknown content
     log Severity.unknown, content
   end

  private

    attr_reader :host, :port, :app_name

    def adapter
      @adapter ||= Fluent::Logger::FluentLogger.new(app_name, :host=>host, :port=>port)
    end

  end
end
