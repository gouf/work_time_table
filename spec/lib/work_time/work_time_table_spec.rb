# frozen_string_literal: true

describe DayInWorkTime::WorkTimeTable do
  context '「通勤1.5時間, 10時開始, 8時間勤務」設定の場合' do
    subject do
      DayInWorkTime::WorkTimeTable.create(
        preparing_hours: 1,
        base_time: Time.new(2019, 6, 1, 10, 0),
        commuting_hours: 1.5,
        work_hours: 8
      )
    end

    # 「準備時間」「通勤時間(行き)」「勤務時間」「通勤時間(帰り)」
    it '時間の範囲を示した4つの配列が返る' do
      expected = [
        '07:30 〜 08:30',
        '08:30 〜 10:00',
        '10:00 〜 18:00',
        '18:00 〜 19:30'
      ]

      expect(subject.values).to match_array expected
    end
  end
end
