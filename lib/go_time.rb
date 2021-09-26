# frozen_string_literal: true

require_relative "go_time/convert_table"
require_relative "go_time/constants"
require_relative "go_time/refine"
require_relative "go_time/version"

# formats Time like Golang
module GoTime
  # Formats time according to Go-like format string
  #
  # @param [Time] time
  # @param [String] fmt Go-like format string
  # @return [String] formatted string
  def self.format(time, fmt)
    update_convert_regexp unless @convert_regexp

    fmt.gsub(@convert_regexp) do |matched|
      conv = @convert_table[matched]
      case conv
      when String
        time.respond_to?(:_orig_strftime) ? time._orig_strftime(conv) : time.strftime(conv)
      when Proc
        conv.call(time, matched)
      end
    end
  end

  # Formats time according to Go-like format or strftime format string
  #
  # @param [Time] time
  # @param [String] fmt Go-like format or strftime format string
  # @return [String] formatted string
  def self.strftime(time, fmt)
    update_convert_regexp unless @convert_regexp

    converted_fmt = fmt.gsub(@convert_regexp) do |matched|
      conv = @convert_table[matched]
      case conv
      when String
        conv
      when Proc
        conv.call(time, matched)
      end
    end

    time.respond_to?(:_orig_strftime) ? time._orig_strftime(converted_fmt) : time.strftime(converted_fmt)
  end

  # Converts Go-like format string to strftime format string
  #
  # @param [String] fmt Go-like format string
  # @return [String] strftime format string
  def self.convert(fmt)
    fmt.gsub(BASIC_CONVERT_REGEXP, BASIC_CONVERT_TABLE)
  end

  def self.update_convert_regexp
    @convert_regexp = Regexp.union(@convert_table.keys)
  end
end
