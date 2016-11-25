require "fluentdly/version"
require "fluentdly/logger"
require "fluentdly/task"
require "fluentdly/configuration"

module Fluentdly

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
