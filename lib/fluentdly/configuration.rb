module Fluentdly
  class Configuration

    attr_accessor :task_logger

    def task_logger
      @task_logger ||= Logger.new(:host => 'localhost', :port => '24224', :app_name => 'test')
    end

  end
end
