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
      status, result = block.call
      content = parameters.merge(:status => status)

      logger.log(severity, content)
      result
    end

  end
end
