require 'rack'

module Fluentdly
  module Rack
    class Middleware
      class Standard

        def self.call *args
          formatter = new(*args)
          formatter.call
        end

        def initialize env, time, result
          @env  = env
          @time = time

          @status, _headers, _body = result
        end

        def call
          "Completed #{method} #{path_and_params} with #{status} in #{time}ms"
        end

      private

        def path_and_params
          if query_string.empty?
            path
          else
            "#{path}?#{query_string}"
          end
        end

        def method
          env['REQUEST_METHOD']
        end

        def query_string
          env['QUERY_STRING']
        end

        def path
          env['PATH_INFO']
        end

        attr_reader :env, :time, :status

      end
    end
  end
end
