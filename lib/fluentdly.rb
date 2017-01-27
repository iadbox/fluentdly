require "fluentdly/version"
require "fluentdly/severity"
require "fluentdly/logger"
require "fluentdly/task"
require "fluentdly/timer"
require "fluentdly/configuration"
require "fluentdly/rack/middleware"

module Fluentdly

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
