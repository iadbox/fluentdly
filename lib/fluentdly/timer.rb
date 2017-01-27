module Fluentdly
  class Timer

    def self.measure
      start_time = Time.now
      result     = yield
      end_time   = Time.now

      duration = (end_time - start_time) * 1000
      [duration, result]
    end

  end
end
