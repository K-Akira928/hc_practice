# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new

option_params = {}
opt.on('-m') { |v| v }
opt.parse!(ARGV, into: option_params)

# 月毎の日数
@number_of_days_in_month = {
  january: 1..31,
  february: 1..28,
  march: 1..31,
  april: 1..30,
  may: 1..31,
  june: 1..30,
  july: 1..31,
  august: 1..31,
  september: 1..30,
  october: 1..31,
  november: 1..30,
  december: 1..31
}

# 表示用の曜日
@display_weeks = %w[月 火 水 木 金 土 日]

@current_year = Time.now.year
@select_month = Time.now.month

# 表示する月の最初の曜日を取得する
def first_month_wday
  day_weeks = %w[日 月 火 水 木 金 土]
  day_weeks[Time.new(@current_year, @select_month, 1).strftime('%w').to_i]
end

# 日にちの成形
def display_days
  month_english_name = Time.new(@current_year, @select_month).strftime('%B').downcase

  # うるう年の判定
  @number_of_days_in_month[:february] = 1..29 if Time.new(@current_year, 12, 31).yday == 366

  days = @number_of_days_in_month[month_english_name.to_sym].to_a.map do |day|
    day.to_s.rjust(2)
  end
  @display_weeks.index(first_month_wday).times { days.unshift '  ' }
  days
end

# 日にちをカレンダー表示へ成形
def display_calendar(days)
  days.map.with_index do |day, i|
    day.concat("\n") if ((i + 1) % 7).zero?
  end
  days.push("\n")
  days.unshift('')
end

# ターミナルへの表示
def display_terminal(display_days)
  puts "#{@select_month}月 #{@current_year}年".center(21)
  puts @display_weeks.join(' ').rjust(14)
  puts display_calendar(display_days).join(' ')
end

# option_params[:m]の値がfalseの場合、当月を表示する(-m入力がない)
if !option_params[:m]
  # 当月のカレンダーを表示
  display_terminal(display_days)
elsif Range.new(1, 12).to_a.find { |i| i == ARGV[0].to_i }
  # コマンドで指定されたカレンダーを表示
  @select_month = ARGV[0].to_s.rjust(2).gsub(/ /, '0').to_i
  display_terminal(display_days)
else
  # 不正な値を入力するとエラーを表示する
  raise "#{ARGV[0]} is neither a month number (1..12) nor a name"
end
