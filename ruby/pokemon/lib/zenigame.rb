# frozen_string_literal: true

require_relative 'pokemon'

# ポケモンクラスを継承したゼニガメクラスです
class Zenigame < Pokemon
  def attack
    "#{@name}のみずでっぽう！"
  end
end
