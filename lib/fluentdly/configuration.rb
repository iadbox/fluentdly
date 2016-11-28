module Fluentdly
  class Configuration

    attr_accessor :task_logger, :request_parameters

    def task_logger
      @task_logger ||= Logger.new(:host => 'localhost', :port => '24224', :app_name => 'test')
    end

    def request_parameters custom_parameters = {}
      @request_parameters = {
        :request_method => 'REQUEST_METHOD',
        :query_string   => 'QUERY_STRING',
        :request_uri    => 'REQUEST_URI',
        :user_agent     => 'HTTP_USER_AGENT'
      }

      @request_parameters.merge(custom_parameters)
    end

  end
end
