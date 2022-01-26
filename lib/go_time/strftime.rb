# frozen_string_literal: true

require "go_time"

class Time
  alias _orig_strftime strftime

  def strftime(fmt)
    GoTime.strftime(self, fmt)
  end
end
