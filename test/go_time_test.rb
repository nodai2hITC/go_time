# frozen_string_literal: true

require "test_helper"

class GoTimeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GoTime::VERSION
  end

  def test_format
    time = Time.utc(2012, 3, 4, 17, 6, 7, 80000)
    time_am = Time.utc(2012, 3, 4, 5, 6, 7, 80000)
    time_local = Time.new(2012, 3, 4, 17, 6, 7, "+09:00")

    assert_equal "2012", GoTime.format(time, "2006")
    assert_equal "12", GoTime.format(time, "06")
    assert_equal "17", GoTime.format(time, "15")
    assert_equal "05", GoTime.format(time, "03")
    assert_equal "5", GoTime.format(time, "3")
    assert_equal "March", GoTime.format(time, "January")
    assert_equal "Mar", GoTime.format(time, "Jan")
    assert_equal "03", GoTime.format(time, "01")
    assert_equal "3", GoTime.format(time, "1")
    assert_equal "Sunday", GoTime.format(time, "Monday")
    assert_equal "Sun", GoTime.format(time, "Mon")
    assert_equal " 64", GoTime.format(time, "__2")
    assert_equal "064", GoTime.format(time, "002")
    assert_equal " 4", GoTime.format(time, "_2")
    assert_equal "04", GoTime.format(time, "02")
    assert_equal "4", GoTime.format(time, "2")
    assert_equal "06", GoTime.format(time, "04")
    assert_equal "6", GoTime.format(time, "4")
    assert_equal "07", GoTime.format(time, "05")
    assert_equal "7", GoTime.format(time, "5")
    assert_equal "PM", GoTime.format(time, "PM")
    assert_equal "pm", GoTime.format(time, "pm")
    assert_equal "+00:00:00", GoTime.format(time, "-07:00:00")
    assert_equal "+00:00", GoTime.format(time, "-07:00")
    assert_equal "+000000", GoTime.format(time, "-070000")
    assert_equal "+0000", GoTime.format(time, "-0700")
    assert_equal "+00", GoTime.format(time, "-07")
    assert_equal "Z", GoTime.format(time, "Z07:00:00")
    assert_equal "Z", GoTime.format(time, "Z07:00")
    assert_equal "Z", GoTime.format(time, "Z070000")
    assert_equal "Z", GoTime.format(time, "Z0700")
    assert_equal "Z", GoTime.format(time, "Z07")
    assert_equal ".080000000", GoTime.format(time, ".000000000")
    assert_equal ".080000", GoTime.format(time, ".000000")
    assert_equal ".080", GoTime.format(time, ".000")
    assert_equal ",080000000", GoTime.format(time, ",000000000")
    assert_equal ",080000", GoTime.format(time, ",000000")
    assert_equal ",080", GoTime.format(time, ",000")
    assert_equal ".08", GoTime.format(time, ".999999999")
    assert_equal ".08", GoTime.format(time, ".999999")
    assert_equal ".08", GoTime.format(time, ".999")
    assert_equal ",08", GoTime.format(time, ",999999999")
    assert_equal ",08", GoTime.format(time, ",999999")
    assert_equal ",08", GoTime.format(time, ",999")

    assert_equal "AM", GoTime.format(time_am, "PM")
    assert_equal "am", GoTime.format(time_am, "pm")

    assert_equal "+09:00:00", GoTime.format(time_local, "Z07:00:00")
    assert_equal "+09:00", GoTime.format(time_local, "Z07:00")
    assert_equal "+090000", GoTime.format(time_local, "Z070000")
    assert_equal "+0900", GoTime.format(time_local, "Z0700")
    assert_equal "+09", GoTime.format(time_local, "Z07")
  end

  def test_example_timeformat
    # 2012/03/04 05:06:07.080000+09:00
    time = Time.at(1330848367, 80000, in: "+09:00")
    
    #            "01/02 03:04:05PM '06 -0700"
    assert_equal "03/04 05:06:07PM '12 +0900", GoTime.format(time, GoTime::Layout)
    #            "Mon Jan _2 15:04:05 2006"
    assert_equal "Sun Mar  4 17:06:07 2012", GoTime.format(time, GoTime::ANSIC)
    #            "Mon Jan 02 15:04:05 -0700 2006"
    assert_equal "Sun Mar 04 17:06:07 +0900 2012", GoTime.format(time, GoTime::RubyDate)
    #            "02 Jan 06 15:04 -0700"
    assert_equal "04 Mar 12 17:06 +0900", GoTime.format(time, GoTime::RFC822Z)
    #            "Mon, 02 Jan 2006 15:04:05 -0700"
    assert_equal "Sun, 04 Mar 2012 17:06:07 +0900", GoTime.format(time, GoTime::RFC1123Z)
    #            "2006-01-02T15:04:05Z07:00"
    assert_equal "2012-03-04T17:06:07+09:00", GoTime.format(time, GoTime::RFC3339)
    #            "2006-01-02T15:04:05.999999999Z07:00"
    assert_equal "2012-03-04T17:06:07.08+09:00", GoTime.format(time, GoTime::RFC3339Nano)
    #            "3:04PM"
    assert_equal "5:06PM", GoTime.format(time, GoTime::Kitchen)
    #            "Jan _2 15:04:05"
    assert_equal "Mar  4 17:06:07", GoTime.format(time, GoTime::Stamp)
    #            "Jan _2 15:04:05.000"
    assert_equal "Mar  4 17:06:07.080", GoTime.format(time, GoTime::StampMilli)
    #            "Jan _2 15:04:05.000000"
    assert_equal "Mar  4 17:06:07.080000", GoTime.format(time, GoTime::StampMicro)
    #            "Jan _2 15:04:05.000000000"
    assert_equal "Mar  4 17:06:07.080000000", GoTime.format(time, GoTime::StampNano)
  end
end
