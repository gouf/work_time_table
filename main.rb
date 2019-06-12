# frozen_string_literal: true

require_relative 'lib/work_time'

def work_time_table(work_start_hour:, commuting_hours:, work_hours:)
  work_time =
    DayInWorkTime::WorkTimeTable.create(
      preparing_hours: 1, # 1 時間で支度しな！
      base_time: Time.new(2019, 6, 1, work_start_hour, 0), # 年月日, 分はテキトー。フォーマット時に時分のみ取り出すため
      work_hours: work_hours,
      commuting_hours: commuting_hours
    )

  # FIXME: ハイフンの 50, ljust の15 は決め打ちなので可変にしたい
  [
    "「#{work_start_hour} 時勤務開始, #{work_hours} 時間勤務, #{commuting_hours} 時間通勤」の場合",
    '-' * 50,
    work_time.map { |key, value| "#{key.to_s.ljust(15)}: #{value}" }
  ]
end

puts work_time_table(
  work_start_hour: 10,  # 勤務開始時刻(時)
  commuting_hours: 0, # 通勤時間(時)
  work_hours: 8 + 0     # 休憩含む全体の勤務時間(時). 「通常 + 残業」
)
