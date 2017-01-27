module Fluentdly
  class Configuration

    attr_writer :task_logger
    attr_accessor :request_parameters

    def task_logger
      @task_logger ||= Logger.new(:host => 'localhost', :port => '24224', :app_name => 'test')
    end

    def request_parameters custom_parameters = {}
      @request_parameters = {
        :method => 'REQUEST_METHOD',
        :path   => 'PATH_INFO'
      }

      @request_parameters.merge(custom_parameters)
    end

  end
end
