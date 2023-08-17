# frozen_string_literal: true

require 'optparse'
require 'date'

opt = OptionParser.new

option_params = {}
opt.on('-m VAL') { |v| v }
opt.parse!(ARGV, into: option_params)

this_year = Date.today.year
select_month = option_params[:m] || Date.today.mon.to_s

# 表示する月の最初の曜日を取得する
def first_month_wday(year, month)
  day_weeks = %w[日 月 火 水 木 金 土]
  day_weeks[Date.new(year, month).strftime('%w').to_i]
end

# 日にちの成形
def display_days(year, month)
  days = (1..Date.new(year, month, -1).day).to_a.map do |day|
    day.to_s.rjust(2)
  end
  %w[月 火 水 木 金 土 日].index(first_month_wday(year, month)).times { days.unshift '  ' }
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
def display_terminal(year, month)
  days = display_days(year, month)
  puts "#{month}月 #{year}年".center(21)
  puts %w[月 火 水 木 金 土 日].join(' ').rjust(14)
  puts display_calendar(days).join(' ')
end

# オプション入力が不正な値の場合、エラーを表示
raise "#{select_month} is neither a month number (1..12) nor a name" unless Range.new('1', '12').to_a.find do |i|
  i == select_month
end

display_terminal(this_year, select_month.to_i)
