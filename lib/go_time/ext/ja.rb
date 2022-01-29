# frozen_string_literal: true

require "go_time"

module GoTime
  module Ja
    CHINESE_NUMERALS = %w[
      〇 一 二 三 四 五 六 七 八 九
      十 十一 十二 十三 十四 十五 十六 十七 十八 十九
      二十 二十一 二十二 二十三 二十四 二十五 二十六 二十七 二十八 二十九
      三十 三十一 三十二 三十三 三十四 三十五 三十六 三十七 三十八 三十九
      四十 四十一 四十二 四十三 四十四 四十五 四十六 四十七 四十八 四十九
      五十 五十一 五十二 五十三 五十四 五十五 五十六 五十七 五十八 五十九
      六十 六十一 六十二 六十三 六十四 六十五 六十六 六十七 六十八 六十九
      七十 七十一 七十二 七十三 七十四 七十五 七十六 七十七 七十八 七十九
      八十 八十一 八十二 八十三 八十四 八十五 八十六 八十七 八十八 八十九
      九十 九十一 九十二 九十三 九十四 九十五 九十六 九十七 九十八 九十九
    ].freeze

    FULLWIDTH_NUMBERS = %w[
      ０ １ ２ ３ ４ ５ ６ ７ ８ ９
      １０ １１ １２ １３ １４ １５ １６ １７ １８ １９
      ２０ ２１ ２２ ２３ ２４ ２５ ２６ ２７ ２８ ２９
      ３０ ３１ ３２ ３３ ３４ ３５ ３６ ３７ ３８ ３９
      ４０ ４１ ４２ ４３ ４４ ４５ ４６ ４７ ４８ ４９
      ５０ ５１ ５２ ５３ ５４ ５５ ５６ ５７ ５８ ５９
      ６０ ６１ ６２ ６３ ６４ ６５ ６６ ６７ ６８ ６９
      ７０ ７１ ７２ ７３ ７４ ７５ ７６ ７７ ７８ ７９
      ８０ ８１ ８２ ８３ ８４ ８５ ８６ ８７ ８８ ８９
      ９０ ９１ ９２ ９３ ９４ ９５ ９６ ９７ ９８ ９９
    ].freeze

    ERA_REPRESENTATIONS = {
      "令和" => { "平成" => "令和", "㍻" => "㋿", "Ｈ" => "Ｒ", "H" => "R" }.freeze,
      "平成" => { "平成" => "平成", "㍻" => "㍻", "Ｈ" => "Ｈ", "H" => "H" }.freeze,
      "昭和" => { "平成" => "昭和", "㍻" => "㍼", "Ｈ" => "Ｓ", "H" => "S" }.freeze,
      "大正" => { "平成" => "大正", "㍻" => "㍽", "Ｈ" => "Ｔ", "H" => "T" }.freeze,
      "明治" => { "平成" => "明治", "㍻" => "㍾", "Ｈ" => "Ｍ", "H" => "M" }.freeze
    }.freeze

    def self.japanese_year(time)
      if time >= Time.new(2019, 4, 30)
        ["令和", time.year - 2018]
      elsif time >= Time.new(1989, 1, 8)
        ["平成", time.year - 1988]
      elsif time >= Time.new(1926, 12, 25)
        ["昭和", time.year - 1925]
      elsif time >= Time.new(1912, 7, 30)
        ["大正", time.year - 1911]
      elsif time >= Time.new(1868, 1, 25)
        ["明治", time.year - 1867]
      else
        raise RangeError
      end
    end
  end

  @convert_table["二〇〇六"] = lambda { |t, _s|
    t.year.to_s.tr("0123456789", "〇一二三四五六七八九")
  }
  @convert_table["２００６"] = lambda { |t, _s|
    t.year.to_s.tr("0123456789", "０１２３４５６７８９")
  }
  @convert_table["０６"] = lambda { |t, _s|
    t.year.to_s[-2, 2].tr("0123456789", "０１２３４５６７８９")
  }
  @convert_table["平成"] = @convert_table["㍻"] = lambda { |t, s|
    era, _year = Ja.japanese_year(t)
    Ja::ERA_REPRESENTATIONS[era][s]
  }
  @convert_table["Ｈ１８"] = @convert_table["H１８"] = lambda { |t, s|
    era, year = Ja.japanese_year(t)
    "#{Ja::ERA_REPRESENTATIONS[era][s[0]]}#{Ja::FULLWIDTH_NUMBERS[year]}"
  }
  @convert_table["H18"] = lambda { |t, _s|
    era, year = Ja.japanese_year(t)
    "#{Ja::ERA_REPRESENTATIONS[era]['H']}#{sprintf('%02d', year)}"
  }
  @convert_table["十八年"] = lambda { |t, _s|
    _era, year = Ja.japanese_year(t)
    "#{year == 1 ? '元' : Ja::CHINESE_NUMERALS.at(year)}年"
  }
  @convert_table["１８年"] = lambda { |t, _s|
    _era, year = Ja.japanese_year(t)
    "#{year == 1 ? '元' : Ja::FULLWIDTH_NUMBERS.at(year)}年"
  }
  @convert_table["18年"] = lambda { |t, _s|
    _era, year = Ja.japanese_year(t)
    "#{year == 1 ? '元' : sprintf('%02d', year)}年"
  }
  @convert_table["十八"] = lambda { |t, _s|
    _era, year = Ja.japanese_year(t)
    Ja::CHINESE_NUMERALS.at(year)
  }
  @convert_table["１８"] = lambda { |t, _s|
    _era, year = Ja.japanese_year(t)
    Ja::FULLWIDTH_NUMBERS.at(year)
  }
  @convert_table["18"] = lambda { |t, _s|
    _era, year = Ja.japanese_year(t)
    sprintf("%02d", year)
  }
  @convert_table["十五"] = ->(t, _s) { Ja::CHINESE_NUMERALS.at(t.hour) }
  @convert_table["１５"] = ->(t, _s) { "０#{Ja::FULLWIDTH_NUMBERS.at(t.hour)}"[-2, 2] }
  @convert_table["一"] = ->(t, _s) { Ja::CHINESE_NUMERALS.at(t.month) }
  @convert_table["０１"] = ->(t, _s) { "０#{Ja::FULLWIDTH_NUMBERS.at(t.month)}"[-2, 2] }
  @convert_table["１"] = ->(t, _s) { Ja::FULLWIDTH_NUMBERS.at(t.month) }
  @convert_table["睦月"] = lambda { |t, _s|
    %w[睦月 如月 弥生 卯月 皐月 水無月 文月 葉月 長月 神無月 霜月 師走].at(t.month - 1)
  }
  @convert_table["二"] = ->(t, _s) { Ja::CHINESE_NUMERALS.at(t.mday) }
  @convert_table["０２"] = ->(t, _s) { "０#{Ja::FULLWIDTH_NUMBERS.at(t.mday)}"[-2, 2] }
  @convert_table["＿２"] = ->(t, _s) { "　#{Ja::FULLWIDTH_NUMBERS.at(t.mday)}"[-2, 2] }
  @convert_table["２"] = ->(t, _s) { Ja::FULLWIDTH_NUMBERS.at(t.mday) }
  @convert_table["火"] = ->(t, _s) { %w[日 月 火 水 木 金 土].at(t.wday) }
  @convert_table["午後"] = ->(t, _s) { t.hour < 12 ? "午前" : "午後" }
  @convert_table["ＰＭ"] = ->(t, _s) { t.hour < 12 ? "ＡＭ" : "ＰＭ" }
  @convert_table["ｐｍ"] = ->(t, _s) { t.hour < 12 ? "ａｍ" : "ｐｍ" }
  @convert_table["三"] = ->(t, _s) { Ja::CHINESE_NUMERALS.at(t.hour % 12) }
  @convert_table["０３"] = ->(t, _s) { "０#{Ja::FULLWIDTH_NUMBERS.at(t.hour % 12)}"[-2, 2] }
  @convert_table["３"] = ->(t, _s) { Ja::FULLWIDTH_NUMBERS.at(t.hour % 12) }
  @convert_table["四"] = ->(t, _s) { Ja::CHINESE_NUMERALS.at(t.min) }
  @convert_table["０４"] = ->(t, _s) { "０#{Ja::FULLWIDTH_NUMBERS.at(t.min)}"[-2, 2] }
  @convert_table["４"] = ->(t, _s) { Ja::FULLWIDTH_NUMBERS.at(t.min) }
  @convert_table["五"] = ->(t, _s) { Ja::CHINESE_NUMERALS.at(t.sec) }
  @convert_table["０５"] = ->(t, _s) { "０#{Ja::FULLWIDTH_NUMBERS.at(t.sec)}"[-2, 2] }
  @convert_table["５"] = ->(t, _s) { Ja::FULLWIDTH_NUMBERS.at(t.sec) }

  update_convert_regexp
end
