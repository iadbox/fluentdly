require 'fluent-logger'

module Fluentdly
  class Logger

    def initialize config
      @host     = config.fetch(:host,     'localhost')
      @port     = config.fetch(:port,     24224)
      @app_name = config.fetch(:app_name, 'myapp')
    end

    def log severity, content, &block
      message = content || block.call
      payload = format(message, severity)

      adapter.post(severity, payload)
    end

    def info (content = nil, &block)
      log Severity.info, content, &block
    end

    def warn (content = nil, &block)
      log Severity.info, content, &block
    end

    def debug (content = nil, &block)
      log Severity.info, content, &block
    end

    def error (content = nil, &block)
      log Severity.info, content, &block
    end

    def fatal (content = nil, &block)
      log Severity.info, content, &block
    end

    def unknown (content = nil, &block)
      log Severity.info, content, &block
    end

    [:debug?, :info?, :warn?, :error?, :fatal?].each do |level|
      define_method(level) { true }
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
