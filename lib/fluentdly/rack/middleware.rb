require "fluentdly/rack/middleware/debug"
require "fluentdly/rack/middleware/standard"

module Fluentdly
  module Rack
    class Middleware

      def initialize app, config = Fluentdly.configuration
        @app        = app
        @logger     = config.task_logger
        @parameters = config.request_parameters
      end

      def call env
        time, result = Timer.measure do
          app.call(env)
        end

        logger.info(params(env, time, result))
        result
      end

    private

      def params env, time, result
        message = format(env, time, result)
        status  = get_status(result)

        custom(env).merge :status => status, :message => message, :time => time
      end

      def format env, time, result
        if logger.debug?
          Debug.call(env, time, result)
        else
          Standard.call(env, time, result)
        end
      end

      def get_status result
        status, _headers, _body = result
        status.to_s
      end

      def custom env
        parameters.each_with_object({}) do |(k,v), result|
          result[k] = env[v]
        end
      end

      attr_reader :app, :logger, :parameters

    end
  end
end
