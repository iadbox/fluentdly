require 'fluent-logger'

module Fluentdly
  class Logger

    attr_accessor :level, :datetime_format

    def initialize config
      @host     = config.fetch(:host,     'localhost')
      @port     = config.fetch(:port,     24224)
      @app_name = config.fetch(:app_name, 'myapp')
      @level    = Severity.info
    end

    def log severity, content = nil, &block
      message = content || block.call
      payload = format(message, severity)

      if level <= severity
        adapter.post(severity, payload)
      end
    end
    alias_method :add, :log

    def debug?
      level <= Severity.debug
    end
    def debug (content = nil, &block)
      log Severity.info, content, &block
    end

    def info?
      level <= Severity.info
    end
    def info (content = nil, &block)
      log Severity.info, content, &block
    end
    alias_method :<<, :info

    def warn?
      level <= Severity.warn
    end
    def warn (content = nil, &block)
      log Severity.info, content, &block
    end

    def error?
      level <= Severity.error
    end
    def error (content = nil, &block)
      log Severity.info, content, &block
    end

    def fatal?
      level <= Severity.fatal
    end
    def fatal (content = nil, &block)
      log Severity.info, content, &block
    end

    def unknown (content = nil, &block)
      log Severity.info, content, &block
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
