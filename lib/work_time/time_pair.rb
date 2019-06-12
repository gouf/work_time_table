# frozen_string_literal: true

require_relative 'exceptions/invalid_order_work_time_pair'

# Time から文字列表記に変換する際のフォーマットを提供する
module TimeFormatter
  refine Time do
    def to_hour_and_minute
      strftime('%H:%M')
    end
  end
end

class DayInWorkTime
  # 時間帯を表現するための始点と終点のセットを生成する
  class TimePair
    using ::TimeFormatter

    attr_reader :first, :last, :pair

    # Time 型の引数を期待
    def initialize(first, last)
      @first = first
      @last = last
      @pair = [first, last]

      raise Exceptions::InvalidOrderDayInWorkTimePair if first > last
    end

    def to_s
      @pair.map(&:to_hour_and_minute).join(' 〜 ')
    end
  end
end
