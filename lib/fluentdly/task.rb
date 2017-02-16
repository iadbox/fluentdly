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
      content = parameters.merge(:status => status, :time => time_diff, :message => format_message(status,time_diff))

      logger.log(severity, content)
      result
    end

    private

      def format_message status, time
        formatted_parameters = parameters.map{ |k,v| "#{k}: #{v}"}.join(", ")

        "Task with params #{formatted_parameters}, finished with #{status} in #{time}"
      end
  end
end
