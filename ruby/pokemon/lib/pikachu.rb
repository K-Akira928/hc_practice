# frozen_string_literal: true

require_relative 'pokemon'

# ポケモンクラスを継承したピカチュウクラス
class Picachu < Pokemon
  def attack
    "#{@name}の10万ボルト！"
  end
end
