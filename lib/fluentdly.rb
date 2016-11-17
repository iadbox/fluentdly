require "fluentdly/version"

module Fluentdly
  class Logger

    def initialize config
      @host     = config.fetch(:host,     'localhost')
      @port     = config.fetch(:port,     24224)
      @app_name = config.fetch(:app_name, 'myapp')
    end

    def log severity, content
      message = content.merge(:severity => severity)
      adapter.log_post(message)
    end

    private

    attr_reader :host, :port, :app_name

    def adapter
      @adapter ||= Fluent::Logger::FluentLogger.new(app_name, :host=>host, :port=>port)
    end

  end
end
