require "fluentdly/version"
require "fluentdly/severity"
require "fluentdly/logger"
require "fluentdly/task"
require "fluentdly/timer"
require "fluentdly/configuration"
if Gem::Specification::find_all_by_name('rack').any?
  require "fluentdly/rack/middleware"
end

module Fluentdly

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
