# frozen_string_literal: true

input_lines = readlines(chomp: true)

# 標準入力で受け取った規定打数とホールスコアを配列と数値に直して格納
regulation_strokes = input_lines[0].split(',').map(&:to_i)
hole_scores = input_lines[1].split(',').map(&:to_i)

# ホールスコア - 規定打数 で得た値を変数に格納
diff_scores = hole_scores.map.with_index do |score, i|
  score - regulation_strokes[i]
end

result_scores = []

diff_scores.each.with_index do |score, i|
  # 規定打数が5かつホールスコアが1の場合 コンドル
  if hole_scores[i] == 1 && regulation_strokes[i] == 5
    result_scores.push 'コンドル'
  # 規定打数が5かつホールスコアが2の場合 アルバトロス
  elsif hole_scores[i] == 2 && regulation_strokes[i] == 5
    result_scores.push 'アルバトロス'
  # 上記のどれでもなく、ホールスコアが1の場合 ホールインワン
  elsif hole_scores[i] == 1
    result_scores.push 'ホールインワン'
  # 規定打数とスコアの差が1の場合 ボギー
  elsif score == 1
    result_scores.push 'ボギー'
  # 規定打数とスコアの差2以上の場合 score + ボギー
  elsif score >= 2
    result_scores.push "#{score}ボギー"
  # 規定打数とスコアの差が0の場合 パー
  elsif score.zero?
    result_scores.push 'パー'
  # 規定打数とスコアの差が-1の場合 バーディ
  elsif score == -1
    result_scores.push 'バーディ'
  # 規定打数とスコアの差が-2の場合 イーグル
  elsif score == -2
    result_scores.push 'イーグル'
  end
end

puts result_scores.join(',')
