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
          "Completed #{method} #{path} (#{params}) with #{status} in #{time}ms"
        end

      private

        def method
          data.request_method
        end

        def path
          data.path_info
        end

        def params
          data.params
        end

        def data
          @data ||= ::Rack::Request.new(env)
        end

        attr_reader :env, :time, :status

      end
    end
  end
end
