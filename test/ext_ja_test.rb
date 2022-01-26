# frozen_string_literal: true

require "test_helper"

class GoTimeTest < Minitest::Test
  def test_ext_ja_timeformat
    require "go_time/ext/ja"

    # 1912/03/04 17:06:07.080000+09:00
    time1 = Time.at(-1824911633, 80000, in: "+09:00")

    assert_equal         "明治四十五年（一九一二年）三月四日(月) 午後五時六分七秒",
      GoTime.format(time1, "平成十八年（二〇〇六年）一月二日(火) 午後三時四分五秒")
    assert_equal           "１９１２年（㍾４５年）３月４日(月) PM５時６分７秒",
      GoTime.format(time1, "２００６年（㍻１８年）１月２日(火) PM３時４分５秒")
    assert_equal           "Ｍ４５ ０３/０４ ０５：０６：０７",
      GoTime.format(time1, "Ｈ１８ ０１/０２ ０３：０４：０５")
    assert_equal           "M45 ３/４ １７：６：７",
      GoTime.format(time1, "H18 １/２ １５：４：５")

    # 2019/05/06 07:08:09.010000+09:00
    time2 = Time.at(1557094089, 10000, in: "+09:00")

    assert_equal             "令和元年 皐月 　６日 午前七時",
      GoTime.format(time2, "平成十八年 睦月 ＿２日 午後三時")
    assert_equal           "R01 ＡＭ０７：０８",
      GoTime.format(time2, "H18 ＰＭ０３：０４")
  end
end
