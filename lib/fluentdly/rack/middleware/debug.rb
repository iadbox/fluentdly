require 'rack/request'

module Fluentdly
  module Rack
    class Middleware
      class Debug

        def self.call *args
          formatter = new(*args)
          formatter.call
        end

        def initialize env, time, result
          @env  = env
          @time = time

          @status, @headers, @body = result
        end

        def call
          %Q(
          Received #{data.request_method} #{data.path_info}
            params: #{data.params.inspect}
          Responded in #{time}ms
            status: #{status}
            headers: #{headers}
            body: #{body.inspect}
          )
        end

      private

        def data
          @data ||= ::Rack::Request.new(env)
        end

        attr_reader :env, :time, :status, :headers, :body

      end
    end
  end
end
