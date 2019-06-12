# frozen_string_literal: true

class DayInWorkTime
  class Exceptions
    # WorkTimePair は「開始時刻 < 終了時刻」の関係でなければならない
    class InvalidOrderDayInWorkTimePair < StandardError
      def message
        "Range pair's order must be a < b"
      end
    end
  end
end
