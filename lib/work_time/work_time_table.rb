# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/time/calculations'
require_relative 'time_pair'

class DayInWorkTime
  # その日 実際に掛かる、労働に関わる時間帯を生成する
  module WorkTimeTable
    class << self
      # 勤務開始時刻を起点に準備, 通勤, 勤務の時間を算出
      # NOTE: フルフレックス制度を想定
      def create(preparing_hours:, base_time:, commuting_hours:, work_hours:)
        time_table = [
          # 準備時間
          TimePair.new(
            start: base_time.advance(hours: -(preparing_hours + commuting_hours)),
            ending: base_time.advance(hours: -commuting_hours)
          ),
          # 通勤時間(行き)
          TimePair.new(
            start: base_time.advance(hours: -commuting_hours),
            ending: base_time
          ),
          # 勤務時間
          TimePair.new(
            start: base_time,
            ending: base_time.advance(hours: work_hours)
          ),
          # 通勤時間(帰り)
          TimePair.new(
            start: base_time.advance(hours: work_hours),
            ending: base_time.advance(hours: work_hours + commuting_hours)
          )
        ]

        labels =
          %i[preparing_time commuting_time working_time back_to_home]

        labels.zip(time_table.map(&:to_s)).to_h
      end
    end
  end
end
