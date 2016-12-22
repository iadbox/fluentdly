require 'fluent-logger'

module Fluentdly
  class Logger

    def initialize config
      @host     = config.fetch(:host,     'localhost')
      @port     = config.fetch(:port,     24224)
      @app_name = config.fetch(:app_name, 'myapp')
    end

    def log severity, content
      payload = format(content, severity)

      adapter.post(severity, payload)
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

    [:debug?, :info?, :warn?, :error?, :fatal?].each do |level|
      define_method(level) { true }
    end

  private

    attr_reader :host, :port, :app_name

    def format content, severity
      if content.is_a?(Hash)
        content.merge(:severity => severity)
      else
        {:message => content, :severity => severity}
      end
    end

    def adapter
      @adapter ||= Fluent::Logger::FluentLogger.new(app_name, :host=>host, :port=>port)
    end

  end
end
