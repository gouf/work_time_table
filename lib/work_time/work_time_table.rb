# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/time/calculations'
require_relative 'time_pair'

class DayInWorkTime
  # その日 実際に掛かる、労働に関わる時間帯を生成する
  module WorkTimeTable
    class << self
      def create(preparing_hours:, base_time:, commuting_hours:, work_hours:)
        time_table = [
          # 準備時間
          TimePair.new(
            base_time.advance(hours: -(preparing_hours + commuting_hours)),
            base_time.advance(hours: -commuting_hours)
          ),
          # 通勤時間(行き)
          TimePair.new(
            base_time.advance(hours: -commuting_hours),
            base_time
          ),
          # 勤務時間
          TimePair.new(
            base_time,
            base_time.advance(hours: work_hours)
          ),
          # 通勤時間(帰り)
          TimePair.new(
            base_time.advance(hours: work_hours),
            base_time.advance(hours: work_hours + commuting_hours)
          )
        ]

        labels =
          %i[preparing_time commuting_time working_time back_to_home]

        labels.zip(time_table.map(&:to_s)).to_h
      end
    end
  end
end
