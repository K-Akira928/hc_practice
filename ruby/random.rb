# frozen_string_literal: true

# のリストを作成(A..F)
group_people = Range.new('A', 'F').to_a

# 組み分けが 2 or 3 になるよう 0..1or2 の乱数を作成
divide_random_num = Range.new(0, rand(1..2))

# group_people 配列をシャッフルする
group_people_shuffle = group_people.shuffle

# シャッフルした配列の前半を乱数に従ってソートして出力
p group_people_shuffle[divide_random_num].sort

# シャッフルした配列の後半を乱数のsizeに従ってソートして出力
p group_people_shuffle[divide_random_num.size..].sort
