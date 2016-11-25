module Fluentdly
  class Task

    def self.log severity, parameters, &block
      task = self.new severity, parameters, block
      task.call
    end

    attr_reader :severity, :parameters, :logger, :block

    def initialize severity, parameters, block, config = Fluentdly.configuration
      @severity   = severity
      @parameters = parameters
      @logger     = config.task_logger
      @block      = block
    end

    def call
      began_at       = Time.now
      status, result = block.call
      finish_at      = Time.now

      time_diff = finish_at - began_at
      content = parameters.merge(:status => status, :time => time_diff)

      logger.log(severity, content)
      result
    end

  end
end
