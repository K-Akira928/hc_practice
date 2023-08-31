# frozen_string_literal: true

require_relative 'name_service'

# 抽象化クラスのように扱うポケモンクラスです
class Pokemon
  # NameServiceからname_changeメソッドとnameメソッドをinclude
  include NameService

  # 引数はrubocopのルールで3文字以上なので、hp => hitpoint に変更
  def initialize(name, type1, type2, hitpoint)
    @name = name
    @type1 = type1
    @type2 = type2
    @hitpoint = hitpoint
  end

  # ポケモンがこうげきする処理(継承先でオーバーライドしないとエラー)
  def attack
    raise 'Method is abstract'
  end
end
