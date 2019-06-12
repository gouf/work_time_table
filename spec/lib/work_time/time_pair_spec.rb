# frozen_string_literal: true

describe DayInWorkTime::TimePair do
  subject { DayInWorkTime::TimePair.new(time_a, time_b) }

  context '時間設定が a < b の場合' do
    let(:time_a) { Time.new(2019, 6, 1, 8, 0) }
    let(:time_b) { Time.new(2019, 6, 1, 10, 0) }

    it do
      expect { subject }.not_to raise_error
    end
  end

  context '時間設定が a > b の場合' do
    let(:time_a) { Time.new(2019, 6, 1, 10, 0) }
    let(:time_b) { Time.new(2019, 6, 1, 8, 0) }

    it do
      expect { subject }.to raise_error(::DayInWorkTime::Exceptions::InvalidOrderDayInWorkTimePair)
    end
  end
end
