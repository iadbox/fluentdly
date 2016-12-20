require 'logger'

module Fluentdly
  module Severity
    include Logger::Severity

    def self.debug
      DEBUG
    end

    def self.info
      INFO
    end

    def self.warn
      WARN
    end

    def self.error
      ERROR
    end

    def self.fatal
      FATAL
    end

    def self.unknown
      UNKNOWN
    end

  end
end
