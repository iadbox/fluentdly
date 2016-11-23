module Fluentdly
  class Task

    def self.log severity, parameters, logger, &block
      task = self.new severity, parameters, logger, block
      task.call
    end

    attr_reader :severity, :parameters, :logger, :block

    def initialize severity, parameters, logger, block
      @severity   = severity
      @parameters = parameters
      @logger     = logger
      @block     = block
    end

    def call
      status, result = block.call
      content = parameters.merge(:status => status)

      logger.log(severity, content)
      result
    end

  end
end
