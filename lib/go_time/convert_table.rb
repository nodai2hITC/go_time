# frozen_string_literal: true

module GoTime
  BASIC_CONVERT_TABLE = {
    "2006"       => "%Y",
    "06"         => "%y",
    "15"         => "%H",
    "03"         => "%I",
    "3"          => "%-I",
    "January"    => "%B",
    "Jan"        => "%b",
    "01"         => "%m",
    "1"          => "%-m",
    "Monday"     => "%A",
    "Mon"        => "%a",
    "__2"        => "%_j",
    "002"        => "%j",
    "_2"         => "%e",
    "02"         => "%d",
    "2"          => "%-d",
    "04"         => "%M",
    "4"          => "%-M",
    "05"         => "%S",
    "5"          => "%-S",
    "PM"         => "%p",
    "pm"         => "%P",
    "MST"        => "%Z",
    "-07:00:00"  => "%::z",
    "-07:00"     => "%:z",
    "-0700"      => "%z",
    ".000000000" => ".%9N",
    ".00000000"  => ".%8N",
    ".0000000"   => ".%7N",
    ".000000"    => ".%6N",
    ".00000"     => ".%5N",
    ".0000"      => ".%4N",
    ".000"       => ".%3N",
    ".00"        => ".%2N",
    ".0"         => ".%1N",
    ",000000000" => ",%9N",
    ",00000000"  => ",%8N",
    ",0000000"   => ",%7N",
    ",000000"    => ",%6N",
    ",00000"     => ",%5N",
    ",0000"      => ",%4N",
    ",000"       => ",%3N",
    ",00"        => ",%2N",
    ",0"         => ",%1N"
  }.freeze
  BASIC_CONVERT_REGEXP = Regexp.union(BASIC_CONVERT_TABLE.keys)

  @convert_table = {
    "Z07:00:00" => ->(t, _s) { t.utc? ? "Z" : t.strftime("%::z") },
    "Z07:00"    => ->(t, _s) { t.utc? ? "Z" : t.strftime("%:z") },
    "Z070000"   => ->(t, _s) { t.utc? ? "Z" : t.strftime("%::z").delete(":") },
    "Z0700"     => ->(t, _s) { t.utc? ? "Z" : t.strftime("%z") },
    "Z07"       => ->(t, _s) { t.utc? ? "Z" : t.strftime("%z").slice(0, 3) },
    "-070000"   => ->(t, _s) { t.strftime("%::z").delete(":") }
  }.merge(BASIC_CONVERT_TABLE).merge({
    "-07" => ->(t, _s) { t.strftime("%z").slice(0, 3) }
  })
  @convert_table[".999999999"] = ->(t, s) { s[0] + t.strftime("%#{s.length - 1}N").sub(/0+$/, "") }
  @convert_table[".99999999"]  = @convert_table[".999999999"]
  @convert_table[".9999999"]   = @convert_table[".999999999"]
  @convert_table[".999999"]    = @convert_table[".999999999"]
  @convert_table[".99999"]     = @convert_table[".999999999"]
  @convert_table[".9999"]      = @convert_table[".999999999"]
  @convert_table[".999"]       = @convert_table[".999999999"]
  @convert_table[".99"]        = @convert_table[".999999999"]
  @convert_table[".9"]         = @convert_table[".999999999"]
  @convert_table[",999999999"] = @convert_table[".999999999"]
  @convert_table[",99999999"]  = @convert_table[".999999999"]
  @convert_table[",9999999"]   = @convert_table[".999999999"]
  @convert_table[",999999"]    = @convert_table[".999999999"]
  @convert_table[",99999"]     = @convert_table[".999999999"]
  @convert_table[",9999"]      = @convert_table[".999999999"]
  @convert_table[",999"]       = @convert_table[".999999999"]
  @convert_table[",99"]        = @convert_table[".999999999"]
  @convert_table[",9"]         = @convert_table[".999999999"]
  @convert_regexp = nil
end
