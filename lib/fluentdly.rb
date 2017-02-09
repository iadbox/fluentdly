require "fluentdly/version"
require "fluentdly/severity"
require "fluentdly/logger"
require "fluentdly/task"
require "fluentdly/timer"
require "fluentdly/configuration"
begin
  require "fluentdly/rack/middleware"
rescue LoadError
  #rack gem is not available
end

module Fluentdly

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
