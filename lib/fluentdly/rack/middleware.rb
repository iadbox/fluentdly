module Fluentdly
  module Rack
    class Middleware

      attr_reader :app, :parameters

      def initialize app, config = Fluentdly.configuration
        @app = app
        @parameters = config.request_parameters
      end

      def call env
        Fluentdly::Task.log(:info, request_parameters(env)) do
          status, * = result = app.call(env)

          [status, result]
        end
      end

      private

      def request_parameters env
        parameters.each_with_object({}) do |(k,v), result|
          result[k] = env[v]
        end
      end
    end
  end
end
