require 'fluent-logger'

module Fluentdly
  class Logger

    attr_accessor :level, :datetime_format

    def initialize config
      @host     = config.fetch(:host,     'localhost')
      @port     = config.fetch(:port,     24224)
      @app_name = config.fetch(:app_name, 'myapp')
      @level    = config.fetch(:level,    Severity.info)
    end

    def log severity, content
      if level <= severity
        payload = format(content, severity)

        adapter.post(severity, payload)
      end
    end
    alias_method :add, :log

    def info?
      level <= Severity.info
    end
    def info content
      log Severity.info, content
    end
    alias_method :<<, :info

    def warn?
      level <= Severity.warn
    end
    def warn content
      log Severity.warn, content
    end

    def debug?
      level <= Severity.debug
    end
    def debug content
      log Severity.debug, content
    end

    def error?
      level <= Severity.error
    end
    def error content
      log Severity.error, content
    end

    def fatal?
      level <= Severity.fatal
    end
    def fatal content
      log Severity.fatal, content
    end

    def unknown content
      log Severity.unknown, content
    end

    def close
      adapter.close
    end

  private

    attr_reader :host, :port, :app_name

    def format content, severity
      if content.is_a?(Hash)
        content.merge(:severity => severity, :service => app_name)
      else
        {:message => content, :severity => severity, :service => app_name}
      end
    end

    def adapter
      @adapter ||= Fluent::Logger::FluentLogger.new(app_name, :host=>host, :port=>port)
    end

  end
end
